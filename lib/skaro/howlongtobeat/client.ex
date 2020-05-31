defmodule Skaro.Howlongtobeat.Client do
  @moduledoc """
  HowLongToBeat client retrieves and parses information from https://howlongtobeat.com
  """

  alias Skaro.HttpClient

  def fetch(%{name: name, release_date: release_date}) do
    with body when is_binary(body) <-
           HttpClient.idempotent_post(
             search_url(),
             {:form,
              [
                {:queryString, name},
                {:t, "games"},
                {:sorthead, "popular"},
                {:sortd, "Normal Order"},
                {:length_type, "main"}
              ]},
             [
               {"Accept", "application/x-www-form-urlencoded"}
             ]
           ),
         {:ok, document} <- Floki.parse_document(body) do
      document
      |> Floki.find("a.text_green")
      |> load_game(release_date)
    end
  end

  defp load_game([{_, attrs, _}], _) do
    {:ok, attrs}
  end

  defp load_game(games = [{_, _, _} | _], release_date) do
    case Enum.filter(games, fn {_, _, [text]} ->
           text |> extract_hltb_year() |> compare_year(release_date)
         end) do
      [game] ->
        load_game([game], release_date)

      [game | _] ->
        load_game([game], release_date)

      [] ->
        {:error, "Not found"}
    end
  end

  defp load_game(_, _) do
    {:error, "Not found"}
  end

  defp extract_hltb_year(text) do
    [_, year_s] = Regex.run(~r/\((\d+)\)/, text)
    {year, _} = Integer.parse(year_s)
    year
  end

  defp compare_year(year, release_date), do: year == release_date.year

  defp search_url, do: "https://howlongtobeat.com/search_results?page=1"
end
