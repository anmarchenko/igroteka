defmodule Skaro.Howlongtobeat.Client do
  @moduledoc """
  HowLongToBeat client retrieves and parses information from https://howlongtobeat.com
  """

  alias Skaro.HttpClient

  def find(%{name: nil}), do: {:error, "name is not given"}
  def find(%{release_date: nil}), do: {:error, "release_date is not given"}

  def find(%{name: name, release_date: release_date}) do
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
      {:error, _} = error_tuple ->
        error_tuple

      body when is_binary(body) ->
        body
        |> Jason.decode!()
        |> Map.get("data", [])
        |> find_game(name, release_date)
    end
  end

  def find(_), do: {:error, "argument is invalid"}

  def get_by_id(nil) do
    {:error, "extracted game id is null"}
  end

  def get_by_id(game_id) do
    with body when is_binary(body) <-
           HttpClient.get(game_url(game_id)),
         {:ok, document} <- Floki.parse_document(body) do
      times =
        document
        |> Floki.find("div[class^=GameStats_game_times] li")
        |> Enum.map(&parse_time/1)
        |> Enum.filter(& &1)

      if Enum.empty?(times) do
        {:error, "Times are not available"}
      else
        {:ok, Enum.into(times, %{external_id: game_id, external_url: game_url(game_id)})}
      end
    else
      {:error, _} = error_tuple ->
        error_tuple
    end
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
        {:error, "Not found"}
    end
  end

  defp find_game(_, _, _) do
    {:error, "Not found"}
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
        nil
    end
  end

  defp search_url, do: "#{base_url()}/api/search"
  defp game_url(game_id), do: "#{base_url()}/game/#{game_id}"

  defp base_url, do: Application.fetch_env!(:skaro, :howlongtobeat)[:base_url]
end
