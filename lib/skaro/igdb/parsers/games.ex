defmodule Skaro.IGDB.Parsers.Games do
  @moduledoc """
  Parses IGDB json to Game struct
  """
  alias Skaro.Core.Game
  alias Skaro.Parser

  alias Skaro.IGDB.Parsers.{
    Companies,
    ExternalLinks,
    Franchises,
    Genres,
    Images,
    Platforms,
    Themes,
    Videos
  }

  def parse_basic(json) when is_list(json), do: Enum.map(json, &parse_basic/1)

  def parse_basic(game) do
    {developers, publishers} = companies(game["involved_companies"])

    %Game{
      id: game["id"],
      external_id: game["id"],
      external_url: game["url"],
      name: game["name"],
      release_date: DateTime.from_unix!(game["first_release_date"]),
      short_description: shorten(game["summary"]),
      rating: game["aggregated_rating"],
      ratings_count: game["aggregated_rating_count"],
      platforms: Platforms.parse_basic(game["platforms"]),
      developers: Companies.parse_basic(developers),
      publishers: Companies.parse_basic(publishers),
      cover: Images.parse_cover(game["cover"])
    }
  end

  def parse_full(json) when is_list(json), do: Enum.map(json, &parse_full/1)

  def parse_full(game) do
    {developers, publishers} = companies(game["involved_companies"])

    %Game{
      id: game["id"],
      external_id: game["id"],
      external_url: game["url"],
      name: game["name"],
      release_date: Parser.parse_date(game["first_release_date"]),
      short_description: game["summary"],
      description: game["storyline"],
      rating: game["aggregated_rating"],
      ratings_count: game["aggregated_rating_count"],
      category: game["category"],
      status: game["status"],
      platforms: Platforms.parse_basic(game["platforms"]),
      cover: Images.parse_cover(game["cover"]),
      franchises: Franchises.parse_basic(game["franchises"]),
      developers: Companies.parse_basic(developers),
      publishers: Companies.parse_basic(publishers),
      external_links: ExternalLinks.parse_basic(game["websites"]),
      videos: Videos.parse_basic(game["videos"]),
      genres: Genres.parse_basic(game["genres"]),
      themes: Themes.parse_basic(game["themes"])
    }
  end

  defp shorten(nil), do: nil
  defp shorten(""), do: ""

  defp shorten(val) do
    if String.length(val) > 300 do
      {res, _} = String.split_at(val, 297)
      "#{res}..."
    else
      val
    end
  end

  defp companies(nil), do: {[], []}

  defp companies(items) do
    developers =
      items
      |> Enum.filter(& &1["developer"])
      |> Enum.map(& &1["company"])

    publishers = items |> Enum.filter(& &1["publisher"]) |> Enum.map(& &1["company"])

    {developers, publishers}
  end
end
