defmodule Skaro.Giantbomb.ThemesParser do
  @moduledoc """
  Set of function to work with themes data
  """
  alias Skaro.Core.Theme

  def parse_many(nil), do: []
  def parse_many(themes_json), do: Enum.map(themes_json, &parse/1)

  def parse(theme_json) do
    %Theme{
      id: theme_json["id"],
      external_id: theme_json["id"],
      name: theme_json["name"]
    }
  end
end
