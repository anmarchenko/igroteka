defmodule Skaro.Howlongtobeat.Client do
  @moduledoc """
  HowLongToBeat client retrieves and parses information from https://howlongtobeat.com
  """

  alias Skaro.HttpClient

  def find(%{name: nil}), do: {:error, "name is not given"}
  def find(%{release_date: nil}), do: {:error, "release_date is not given"}

  def find(%{name: name, release_date: release_date}) do
    with body when is_binary(body) <-
           HttpClient.idempotent_post(
             search_url(),
             {:form,
              [
                {:queryString, name},
                {:t, "games"},
                {:sorthead, "popular"},
                {:sortd, "Normal Order"},
                {:length_type, "main"},
                {:page, 1}
              ]},
             [
               {"Accept", "application/x-www-form-urlencoded"}
             ]
           ),
         {:ok, document} <- Floki.parse_document(body) do
      document
      |> Floki.find("a.text_green")
      |> find_game(release_date)
    else
      {:error, _} = error_tuple ->
        error_tuple
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
        |> Floki.find(".game_times li")
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

  defp find_game([{_, attrs, _}], _) do
    attrs
    |> get_href()
    |> extract_game_id()
    |> get_by_id()
  end

  defp find_game(games = [{_, _, _} | _], release_date) do
    case Enum.filter(games, fn {_, _, [text]} ->
           extract_hltb_year(text) == release_date.year
         end) do
      [game] ->
        find_game([game], release_date)

      [game | _] ->
        find_game([game], release_date)

      [] ->
        {:error, "Not found"}
    end
  end

  defp find_game(_, _) do
    {:error, "Not found"}
  end

  defp extract_hltb_year(text) do
    case Regex.run(~r/\((\d+)\)/, text) do
      [_, year_s] ->
        {year, _} = Integer.parse(year_s)
        year

      _ ->
        nil
    end
  end

  defp get_href([{"href", href} | _]), do: href
  defp get_href([_ | rest]), do: get_href(rest)
  defp get_href([]), do: nil

  defp extract_game_id("game?id=" <> id), do: id
  defp extract_game_id(_), do: nil

  defp parse_time({_, _, [{"h5", _, [label]}, {"div", _, [time]}]}) do
    case String.trim(label) do
      "Main Story" ->
        parse_time_value(:main, time)

      "Main + Extras" ->
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

  defp search_url, do: "#{base_url()}/search_results"
  defp game_url(game_id), do: "#{base_url()}/game?id=#{game_id}"

  defp base_url, do: Application.fetch_env!(:skaro, :howlongtobeat)[:base_url]
end
