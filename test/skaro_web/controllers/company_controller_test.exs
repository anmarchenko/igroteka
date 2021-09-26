defmodule SkaroWeb.CompanyControllerTest do
  @moduledoc false
  use SkaroWeb.ConnCase

  import Mox
  import Skaro.Factory

  setup :verify_on_exit!

  describe "GET :show" do
    setup do
      {:ok, company: build(:company)}
    end

    @tag :login
    test "external api call errored", %{conn: conn} do
      Skaro.GamesRemoteMock
      |> expect(:fetch_company, fn id ->
        assert "123" = id
        {:error, "Object not found"}
      end)

      conn = get(conn, Routes.company_path(@endpoint, :show, 123))

      json = json_response(conn, 503)
      assert json["error"] == "external call failed"

      cached_value =
        ConCache.get(
          :external_api_cache,
          "companies_show_123_v1.0"
        )

      assert nil == cached_value
    end

    @tag :login
    test "external api call succeeded", %{conn: conn, company: company} do
      Skaro.GamesRemoteMock
      |> expect(:fetch_company, fn id ->
        assert "432432" = id
        {:ok, company}
      end)

      conn = get(conn, Routes.company_path(@endpoint, :show, 432_432))

      company_json = json_response(conn, 200)
      assert company_json["id"] == company.id
      assert company_json["name"] == company.name
      assert company_json["website"] == company.website
      assert company_json["description"] == company.description
      assert company_json["logo"]["thumb_url"] == company.logo.thumb_url

      cached_value =
        ConCache.get(
          :external_api_cache,
          "companies_show_432432_v1.0"
        )

      assert company == cached_value
    end
  end
end
