defmodule Skaro.IGDB.Parsers.CompaniesTest do
  @moduledoc false
  use Skaro.DataCase

  alias Skaro.Core.{Company, Image}
  alias Skaro.IGDB.Parsers.Companies

  describe "parse_basic/1" do
    test "no country" do
      assert %Company{
               id: "1",
               name: "Firma",
               external_id: "1",
               external_url: "https://firma.de",
               logo: %Image{
                 big_url: "https://images.igdb.com/igdb/image/upload/t_logo_med_2x/image1.jpg",
                 id: "image1",
                 thumb_url: "https://images.igdb.com/igdb/image/upload/t_thumb/image1.jpg"
               }
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
  end
end
