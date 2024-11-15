defmodule Skaro.Howlongtobeat.Client do
  @moduledoc """
  HowLongToBeat client retrieves and parses information from https://howlongtobeat.com
  """

  alias Skaro.HttpClient

  require OpenTelemetry.Tracer, as: Tracer

  def find(%{name: nil}) do
    Tracer.set_status(OpenTelemetry.status(:error, "Game name is not provided"))
    {:error, :no_name}
  end

  def find(%{release_date: nil}) do
    Tracer.set_status(OpenTelemetry.status(:error, "Game release date is not provided"))
    {:error, :no_date}
  end

  def find(%{name: name, release_date: release_date}) do
    Tracer.with_span "howlongtobeat.client.find", kind: :client, attributes: %{game_name: name} do
      with {:ok, search_url} <- search_url(),
           {:ok, body} <- search_games(search_url, name) do
        body
        |> Jason.decode!()
        |> Map.get("data", [])
        |> find_game(name, release_date)
      else
        {:error, reason} = error_tuple ->
          Tracer.set_attribute(:result, :external_api_search_failure)

          Tracer.set_status(
            OpenTelemetry.status(:error, "Howlongtobeat search failed: #{reason}")
          )

          error_tuple
      end
    end
  end

  def find(_), do: {:error, "argument is invalid"}

  def get_by_id(nil) do
    Tracer.set_attribute(:result, :game_id_not_found)

    Tracer.set_status(
      OpenTelemetry.status(:error, "Game ID is not extracted from howlongtobeat search response")
    )

    {:error, :game_id_not_found}
  end

  def get_by_id(game_id) do
    Tracer.with_span "howlongtobeat.client.get_by_id",
      kind: :client,
      attributes: %{game_id: game_id} do
      with body when is_binary(body) <-
             HttpClient.get(game_url(game_id)),
           {:ok, document} <- Floki.parse_document(body) do
        times =
          document
          |> Floki.find("div[class^=GameStats_game_times] li")
          |> Enum.map(&parse_time/1)
          |> Enum.filter(& &1)

        if Enum.empty?(times) do
          Tracer.set_attribute(:result, :times_not_available)

          Tracer.set_status(
            OpenTelemetry.status(
              :error,
              "Times could not be found in howlongtobeat for game with ID #{game_id}"
            )
          )

          {:error, :times_not_available}
        else
          Tracer.set_attribute(:result, :ok)
          {:ok, Enum.into(times, %{external_id: game_id, external_url: game_url(game_id)})}
        end
      else
        {:error, reason} = error_tuple ->
          Tracer.set_attribute(:result, :external_api_get_by_id_failure)

          Tracer.set_status(
            OpenTelemetry.status(:error, "Howlongtobeat search failed: #{reason}")
          )

          error_tuple
      end
    end
  end

  defp search_games(search_url, name) do
    case HttpClient.idempotent_post(
           search_url,
           Jason.encode!(%{
             "searchType" => "games",
             "searchTerms" => String.split(name),
             "searchPage" => 1,
             "size" => 5,
             "searchOptions" => %{
               "games" => %{
                 "userId" => 0,
                 "platform" => "",
                 "sortCategory" => "popular",
                 "rangeCategory" => "main",
                 "rangeTime" => %{"min" => 0, "max" => 0},
                 "gameplay" => %{"perspective" => "", "flow" => "", "genre" => ""},
                 "modifier" => ""
               },
               "users" => %{"sortCategory" => "postcount"},
               "filter" => "",
               "sort" => 0,
               "randomizer" => 0
             }
           }),
           [
             {"Accept", "*/*"},
             {"Content-Type", "application/json"},
             {"Host", "howlongtobeat.com"},
             {"Origin", "https://howlongtobeat.com"},
             {"Referer", "https://howlongtobeat.com/"}
           ]
         ) do
      body when is_binary(body) ->
        {:ok, body}

      error_tuple ->
        error_tuple
    end
  end

  defp fetch_search_url_path do
    Tracer.with_span "howlongtobeat.client.fetch_main_page", kind: :client do
      with {:ok, body} <-
             fetch_main_page(),
           {:ok, path} <- extract_script_link(body),
           {:ok, js_script} <- fetch_js_code(path),
           {:ok, search_url_path} <- extract_search_path(js_script) do
        {:ok, search_url_path}
      else
        {:error, reason} = error_tuple ->
          Tracer.set_attribute(:result, :external_api_failure)

          Tracer.set_status(
            OpenTelemetry.status(:error, "Howlongtobeat fetching search URL failed: #{reason}")
          )

          error_tuple
      end
    end
  end

  defp fetch_main_page do
    case HttpClient.get(base_url()) do
      body when is_binary(body) ->
        {:ok, body}

      error_tuple ->
        error_tuple
    end
  end

  # extracts the link from <script> tag with file name like _app-XXXXXX.js
  # use regexp to extract the link
  defp extract_script_link(body) do
    case Regex.scan(~r{script.+src\=\"([^\s]+\_app\-[^\s]+\.js)\"}, body) do
      [[_, path]] ->
        {:ok, path}

      _ ->
        {:error, :script_not_found}
    end
  end

  defp fetch_js_code(path) do
    case HttpClient.get("#{base_url()}#{path}") do
      body when is_binary(body) ->
        {:ok, body}

      error_tuple ->
        error_tuple
    end
  end

  # from given js code we need to find code like that:
  # fetch("/api/search/".concat("7b0f03b2").concat("54cc3099")
  # from that we need to match and return "/api/search/7b0f03b254cc3099"
  defp extract_search_path(js_code) do
    case Regex.run(~r{fetch\(\"\/api\/search\/\"(?:\.concat\(\"\w+\"\))+}, js_code) do
      [fetch] ->
        search_path =
          fetch
          |> String.replace("\"", "", global: true)
          |> String.replace("fetch(", "")
          |> String.replace(".concat(", "", global: true)
          |> String.replace(")", "", global: true)

        {:ok, search_path}

      _ ->
        {:error, :search_url_not_parsable}
    end
  end

  defp find_game([game], _, _) do
    Tracer.set_attribute(:result, :ok)

    game
    |> extract_game_id()
    |> get_by_id()
  end

  defp find_game([_ | _] = games, name, release_date) do
    case Enum.filter(games, fn game ->
           String.downcase(game["game_name"]) == String.downcase(name) &&
             game["release_world"] == release_date.year
         end) do
      [game] ->
        find_game([game], name, release_date)

      [game | _] ->
        find_game([game], name, release_date)

      [] ->
        Tracer.set_attribute(:result, :game_not_found_in_external_api_response)

        Tracer.set_status(
          OpenTelemetry.status(
            :error,
            "Could not find game with name #{name} and release date #{release_date}"
          )
        )

        {:error, :not_found}
    end
  end

  defp find_game(_, _, _) do
    Tracer.set_attribute(:result, :game_not_found_in_external_api_response)

    Tracer.set_status(OpenTelemetry.status(:error, "Could not find game"))

    {:error, :not_found}
  end

  defp extract_game_id(%{"game_id" => id}), do: Integer.to_string(id)
  defp extract_game_id(_), do: nil

  defp parse_time({_, _, [{"h4", _, [label]}, {"h5", _, [time]}]}) do
    case String.trim(label) do
      "Main Story" ->
        parse_time_value(:main, time)

      "Main + Sides" ->
        parse_time_value(:main_extra, time)

      "Completionist" ->
        parse_time_value(:completionist, time)

      _ ->
        nil
    end
  end

  defp parse_time(_), do: nil

  defp parse_time_value(key, time) do
    res =
      time
      |> String.replace("Hours", "")
      |> String.replace("½", ".5")
      |> String.trim()
      |> Float.parse()

    case res do
      {num, _} ->
        {key, floor(num * 60)}

      :error ->
        Tracer.set_attribute(:result, :unknown_time_format)

        Tracer.set_status(
          OpenTelemetry.status(
            :error,
            "Could not parse time [#{time}]"
          )
        )

        nil
    end
  end

  # fetches and caches the search URL path for 6 hours
  defp search_url do
    cache_key = "howlongtobeat.search_url"

    case ConCache.get(:external_api_cache, cache_key) do
      nil ->
        case fetch_search_url_path() do
          {:ok, search_url_path} ->
            search_url = "#{base_url()}#{search_url_path}"
            ConCache.put(:external_api_cache, cache_key, search_url)

            {:ok, search_url}

          error_tuple ->
            error_tuple
        end

      result ->
        {:ok, result}
    end
  end

  defp game_url(game_id), do: "#{base_url()}/game/#{game_id}"

  defp base_url, do: Application.fetch_env!(:skaro, :howlongtobeat)[:base_url]
end
