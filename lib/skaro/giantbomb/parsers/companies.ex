defmodule Skaro.Giantbomb.CompaniesParser do
  @moduledoc """
  Set of function to work with companies data
  """
  alias Skaro.Core.Company

  def parse_many(nil), do: []
  def parse_many(companies_json), do: Enum.map(companies_json, &parse_minimal/1)

  def parse_minimal(company_json) do
    %Company{
      id: company_json["id"],
      external_id: company_json["id"],
      name: company_json["name"]
    }
  end
end
