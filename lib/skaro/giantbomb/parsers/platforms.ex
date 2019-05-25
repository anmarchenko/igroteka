defmodule Skaro.Giantbomb.PlatformsParser do
  @moduledoc """
  Set of function to work with platforms data from Giantbomb
  """
  alias Skaro.Core.Platform

  def parse_many(nil), do: []
  def parse_many(platforms_json), do: Enum.map(platforms_json, &parse_minimal/1)

  def parse_minimal(platform_json) do
    %Platform{
      id: platform_json["id"],
      external_id: platform_json["id"],
      name: platform_json["name"]
    }
  end
end
