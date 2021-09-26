defmodule Skaro.IGDB.Parsers.Companies do
  @moduledoc """
  Parses IGDB json to Company struct
  """
  alias Skaro.Core.Company
  alias Skaro.IGDB.Parsers.Images
  alias Skaro.Parser

  @manual_fixes %{
    "Nival Interactive" => "RU",
    "Ubisoft Québec" => "CA",
    "Lucas Pope" => "US",
    "Massive Entertainment" => "SE",
    "Presto Studios" => "US",
    "Westwood Pacific" => "US",
    "Black Isle Studios" => "US",
    "Intelligent Systems" => "JP"
  }

  def parse_full(nil), do: []
  def parse_full(json) when is_list(json), do: Enum.map(json, &parse_full/1)

  def parse_full(company) do
    %Company{
      id: company["id"],
      external_id: company["id"],
      external_url: company["url"],
      name: company["name"],
      description: company["description"],
      country: num_to_alpha2(company["country"], company["name"]),
      logo: Images.parse_logo(company["logo"]),
      website: find_official_website(company["websites"]),
      start_date: Parser.parse_date(company["start_date"])
    }
  end

  @spec parse_basic(nil | maybe_improper_list | map) :: [any] | Skaro.Core.Company.t()
  def parse_basic(nil), do: []
  def parse_basic(json) when is_list(json), do: Enum.map(json, &parse_basic/1)

  def parse_basic(company) do
    %Company{
      id: company["id"],
      external_id: company["id"],
      external_url: company["url"],
      name: company["name"],
      country: num_to_alpha2(company["country"], company["name"])
    }
  end

  defp num_to_alpha2(nil, name),
    do: @manual_fixes[name]

  defp num_to_alpha2(country_code, name) when is_integer(country_code),
    do: country_code |> Integer.to_string() |> String.pad_leading(3, "0") |> num_to_alpha2(name)

  defp num_to_alpha2(country_code, _),
    do: Countries.filter_by(:number, country_code) |> fetch_alpha2()

  defp fetch_alpha2([country | _]), do: country.alpha2
  defp fetch_alpha2(_), do: nil

  defp find_official_website(nil), do: nil
  defp find_official_website([]), do: nil

  defp find_official_website(websites) do
    case Enum.find(websites, fn website -> website["category"] == 1 end) do
      nil ->
        nil

      website = %{} ->
        website["url"]
    end
  end
end
