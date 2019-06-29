defmodule Skaro.IGDB.Parsers.Platforms do
  @moduledoc """
  Parses IGDB json to Platform struct
  """
  alias Skaro.Core.Platform

  def parse_basic(json) when is_list(json), do: Enum.map(json, &parse_basic/1)

  def parse_basic(platform) do
    %Platform{
      external_id: platform["id"],
      name: platform["name"]
    }
  end
end
