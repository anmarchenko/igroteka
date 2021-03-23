defmodule Skaro.IGDB.Parsers.CompaniesTest do
  @moduledoc false
  use Skaro.DataCase

  alias Skaro.Core.Company
  alias Skaro.IGDB.Parsers.Companies

  describe "parse_basic/1" do
    test "no country" do
      assert %Company{
               id: "1",
               name: "Firma",
               external_id: "1",
               external_url: "https://firma.de"
             } =
               Companies.parse_basic(%{
                 "id" => "1",
                 "name" => "Firma",
                 "url" => "https://firma.de",
                 "logo" => %{
                   "image_id" => "image1"
                 }
               })
    end

    test "not existing country" do
      assert %Company{
               id: "1",
               name: "Firma",
               external_id: "1"
             } =
               Companies.parse_basic(%{
                 "id" => "1",
                 "name" => "Firma",
                 "country" => 777
               })
    end

    test "existing country" do
      assert %Company{
               id: "1",
               name: "Firma",
               external_id: "1",
               country: "EE"
             } =
               Companies.parse_basic(%{
                 "id" => "1",
                 "name" => "Firma",
                 "country" => 233
               })
    end

    test "existing country with 2 digits code" do
      assert %Company{
               id: "1",
               name: "Firma",
               external_id: "1",
               country: "BE"
             } =
               Companies.parse_basic(%{
                 "id" => "1",
                 "name" => "Firma",
                 "country" => 56
               })
    end

    test "no country with manual fix defined" do
      assert %Company{
               id: "1",
               name: "Ubisoft Québec",
               external_id: "1",
               country: "CA"
             } =
               Companies.parse_basic(%{
                 "id" => "1",
                 "name" => "Ubisoft Québec"
               })
    end
  end
end
