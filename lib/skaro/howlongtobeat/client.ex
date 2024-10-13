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
      res =
        HttpClient.idempotent_post(
          search_url(),
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
        )

      case res do
        {:error, reason} = error_tuple ->
          Tracer.set_attribute(:result, :external_api_search_failure)

          Tracer.set_status(
            OpenTelemetry.status(:error, "Howlongtobeat search failed: #{reason}")
          )

          error_tuple

        body when is_binary(body) ->
          body
          |> Jason.decode!()
          |> Map.get("data", [])
          |> find_game(name, release_date)
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

  defp search_url, do: "#{base_url()}/api/search/21fda17e4a1d49be"
  defp game_url(game_id), do: "#{base_url()}/game/#{game_id}"

  defp base_url, do: Application.fetch_env!(:skaro, :howlongtobeat)[:base_url]
end
