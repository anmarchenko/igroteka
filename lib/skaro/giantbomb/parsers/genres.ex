defmodule Skaro.Giantbomb.GenresParser do
  @moduledoc """
  Set of function to work with genres data
  """
  alias Skaro.Core.Genre

  def parse_many(nil), do: []
  def parse_many(genres_json), do: Enum.map(genres_json, &parse/1)

  def parse(genre_json) do
    %Genre{
      id: genre_json["id"],
      external_id: genre_json["id"],
      name: genre_json["name"]
    }
  end
end
