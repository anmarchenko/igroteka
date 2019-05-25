defmodule Skaro.Giantbomb.GamesParser do
  @moduledoc """
  Parse giantbomb's json into Game struct
  """

  alias Skaro.Giantbomb.{
    CompaniesParser,
    FranchisesParser,
    GenresParser,
    ImagesParser,
    PlatformsParser,
    ThemesParser
  }

  alias Skaro.Core.Game

  def parse_many({:error, reason}), do: {:error, reason}
  def parse_many({:ok, json}), do: {:ok, Enum.map(json["results"], &parse_minimal/1)}

  def parse_one({:error, reason}), do: {:error, reason}
  def parse_one({:ok, json}), do: {:ok, parse_full(json["results"])}

  def parse_minimal(game) do
    %Game{
      id: game["id"],
      external_id: game["id"],
      name: game["name"],
      release_date: game["original_release_date"],
      short_description: game["deck"],
      cover: ImagesParser.parse(game["image"]),
      platforms: PlatformsParser.parse_many(game["platforms"])
    }
  end

  def parse_full(game) do
    game
    |> parse_minimal
    |> struct(
      developers: CompaniesParser.parse_many(game["developers"]),
      publishers: CompaniesParser.parse_many(game["publishers"]),
      franchises: FranchisesParser.parse_many(game["franchises"]),
      genres: GenresParser.parse_many(game["genres"]),
      themes: ThemesParser.parse_many(game["themes"])
    )
  end
end
