defmodule Skaro.IGDB.Parsers.Companies do
  @moduledoc """
  Parses IGDB json to Company struct
  """
  alias Skaro.Core.Company

  def parse_basic(nil), do: []
  def parse_basic(json) when is_list(json), do: Enum.map(json, &parse_basic/1)

  def parse_basic(company) do
    %Company{
      id: company["id"],
      external_id: company["id"],
      name: company["name"]
    }
  end
end
