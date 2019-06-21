defmodule Skaro.IGDB.Parsers.Games do
  @moduledoc """
  Parses IGDB json to Game struct
  """
  alias Skaro.Core.Game

  def parse_basic(json) when is_list(json), do: {:ok, Enum.map(json, &parse_basic/1)}

  def parse_basic(game) do
    %Game{
      external_id: game["id"],
      name: game["name"],
      release_date: DateTime.from_unix!(game["first_release_date"]),
      short_description: game["summary"],
      rating: game["aggregated_rating"],
      ratings_count: game["aggregated_rating_count"]
    }
  end
end
