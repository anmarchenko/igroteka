defmodule Skaro.IGDB.Parsers.Companies do
  @moduledoc """
  Parses IGDB json to Company struct
  """
  alias Skaro.Core.Company
  alias Skaro.IGDB.Parsers.Images

  @spec parse_basic(nil | maybe_improper_list | map) :: [any] | Skaro.Core.Company.t()
  def parse_basic(nil), do: []
  def parse_basic(json) when is_list(json), do: Enum.map(json, &parse_basic/1)

  def parse_basic(company) do
    %Company{
      id: company["id"],
      external_id: company["id"],
      external_url: company["url"],
      name: company["name"],
      country: num_to_alpha2(company["country"]),
      logo: Images.parse_logo(company["logo"])
    }
  end

  defp num_to_alpha2(country_code) when is_integer(country_code),
    do: country_code |> Integer.to_string() |> num_to_alpha2()

  defp num_to_alpha2(country_code),
    do: Countries.filter_by(:number, country_code) |> fetch_alpha2()

  defp fetch_alpha2([country | _]), do: country.alpha2
  defp fetch_alpha2(_), do: nil
end
