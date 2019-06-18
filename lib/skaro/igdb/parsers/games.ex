defmodule Skaro.IGDB.Parsers.Games do
  @moduledoc """
  Parses IGDB json to Game struct
  """
  alias Skaro.Core.Game

  def parse_many({:error, reason}), do: {:error, reason}
  def parse_many({:ok, json}), do: {:ok, Enum.map(json, &parse_minimal/1)}

  def parse_one({:error, reason}), do: {:error, reason}
  def parse_one({:ok, json}), do: {:ok, parse_full(json)}

  def parse_minimal(data) do
    game = data["game"]

    %Game{
      external_id: game["id"],
      name: game["name"],
      release_date: DateTime.from_unix!(game["first_release_date"]),
      short_description: game["summary"],
      rating: game["aggregated_rating"],
      ratings_count: game["aggregated_rating_count"]
    }
  end

  def parse_full(game) do
    game
    |> parse_minimal()
  end
end
