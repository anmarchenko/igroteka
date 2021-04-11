defmodule Skaro.IGDB.Parsers.Themes do
  @moduledoc """
  Parses IGDB json to Theme struct
  """
  alias Skaro.Core.Theme

  def parse_basic(nil), do: []
  def parse_basic(json) when is_list(json), do: Enum.map(json, &parse_basic/1)

  def parse_basic(theme) do
    %Theme{
      id: theme["id"],
      external_id: theme["id"],
      name: theme["name"]
    }
  end
end
