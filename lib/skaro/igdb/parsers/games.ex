defmodule Skaro.IGDB.Parsers.Games do
  @moduledoc """
  Parses IGDB json to Game struct
  """
  alias Skaro.Core.Game

  alias Skaro.IGDB.Parsers.{Images, Platforms}

  def parse_basic(json) when is_list(json), do: Enum.map(json, &parse_basic/1)

  def parse_basic(game) do
    %Game{
      external_id: game["id"],
      name: game["name"],
      release_date: DateTime.from_unix!(game["first_release_date"]),
      short_description: shorten(game["summary"]),
      rating: game["aggregated_rating"],
      ratings_count: game["aggregated_rating_count"],
      platforms: Platforms.parse_basic(game["platforms"]),
      cover: Images.parse_cover(game["cover"])
    }
  end

  def parse_full(json) when is_list(json), do: Enum.map(json, &parse_full/1)
  def parse_full(game), do: parse_basic(game)

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
end
