defmodule Skaro.IGDB.Parsers.Genres do
  @moduledoc """
  Parses IGDB json to Genre struct
  """
  alias Skaro.Core.Genre

  def parse_basic(nil), do: []
  def parse_basic(json) when is_list(json), do: Enum.map(json, &parse_basic/1)

  def parse_basic(genre) do
    %Genre{
      id: genre["id"],
      external_id: genre["id"],
      name: genre["name"]
    }
  end
end
