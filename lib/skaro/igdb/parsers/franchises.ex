defmodule Skaro.IGDB.Parsers.Franchises do
  @moduledoc """
  Parses IGDB json to Franchise struct
  """
  alias Skaro.Core.Franchise

  def parse_basic(nil), do: []
  def parse_basic(json) when is_list(json), do: Enum.map(json, &parse_basic/1)

  def parse_basic(franchise) do
    %Franchise{
      id: franchise["id"],
      external_id: franchise["id"],
      name: franchise["name"]
    }
  end
end
