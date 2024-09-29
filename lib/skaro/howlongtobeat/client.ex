defmodule Skaro.Howlongtobeat.Client do
  @moduledoc """
  HowLongToBeat client retrieves and parses information from https://howlongtobeat.com
  """

  alias Skaro.HttpClient
  alias Skaro.Tracing

  @event_call [:skaro, :howlongtobeat, :call]
  @event_error [:skaro, :howlongtobeat, :error]

  @action_search :search
  @action_get_by_id :get_by_id

  def find(%{name: nil}) do
    record_error(:no_name, @action_search)
    {:error, :no_name}
  end

  def find(%{release_date: nil}) do
    record_error(:no_date, @action_search)
    {:error, :no_date}
  end

  def find(%{name: name, release_date: release_date}) do
    trace(
      :find,
      fn ->
        res =
          trace(
            :search,
            fn ->
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
            end
          )

        case res do
          {:error, _} = error_tuple ->
            record_error(:search_failed, @action_search)
            error_tuple

          body when is_binary(body) ->
            body
            |> Jason.decode!()
            |> Map.get("data", [])
            |> find_game(name, release_date)
        end
      end
    )
  end

  def find(_), do: {:error, "argument is invalid"}

  def get_by_id(nil) do
    record_error(:game_id_not_found, @action_get_by_id)
    {:error, :game_id_not_found}
  end

  def get_by_id(game_id) do
    trace(
      :get_by_id,
      fn ->
        with body when is_binary(body) <-
               HttpClient.get(game_url(game_id)),
             {:ok, document} <- Floki.parse_document(body) do
          times =
            document
            |> Floki.find("div[class^=GameStats_game_times] li")
            |> Enum.map(&parse_time/1)
            |> Enum.filter(& &1)

          if Enum.empty?(times) do
            record_error(:times_not_available, @action_get_by_id)
            {:error, :times_not_available}
          else
            {:ok, Enum.into(times, %{external_id: game_id, external_url: game_url(game_id)})}
          end
        else
          {:error, _} = error_tuple ->
            record_error(:times_extraction_failed, @action_get_by_id)
            error_tuple
        end
      end
    )
  end

  defp find_game([game], _, _) do
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
        record_error(:game_not_found, @action_search)
        {:error, :not_found}
    end
  end

  defp find_game(_, _, _) do
    record_error(:game_not_found, @action_search)
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
        record_error(:unknown_time_format, @action_get_by_id)
        nil
    end
  end

  defp search_url, do: "#{base_url()}/api/search/21fda17e4a1d49be"
  defp game_url(game_id), do: "#{base_url()}/game/#{game_id}"

  defp base_url, do: Application.fetch_env!(:skaro, :howlongtobeat)[:base_url]

  defp trace(action, fun) do
    Tracing.trace(@event_call, %{action: action}, fun)
  end

  defp record_error(reason, action) do
    Tracing.send_count(@event_error, 1, %{reason: reason, action: action})
  end
end
