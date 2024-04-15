defmodule Skaro.Opencritic.ClientTest do
  @moduledoc false
  use Skaro.DataCase

  alias Plug.Conn

  alias Skaro.Core.Game
  alias Skaro.Opencritic.Client

  describe "find/1" do
    @tag :bypass
    test "happiest path", %{opencritic: opencritic} do
      expect_search(opencritic, "The Witcher 3: Wild Hunt", "search_found")
      expect_game_by_id(opencritic, "463", "witcher3")
      expect_reviews(opencritic, "463", "witcher3_reviews")

      {:ok, rating} = Client.find(%Game{name: "The Witcher 3: Wild Hunt"})

      assert rating[:external_id] == "463"
      assert rating[:tier] == "Mighty"
      assert rating[:percent_recommended] == 95.20958083832335
      assert rating[:score] == 92.57246376811594
      assert rating[:num_reviews] == 152
      assert [%{name: "Forbes", score: 90} | _] = rating[:reviews]
    end

    @tag :bypass
    test "not found", %{opencritic: opencritic} do
      expect_search(opencritic, "Alan Wake II", "search_not_found")

      {:error, :not_found} = Client.find(%Game{name: "Alan Wake II"})
    end

    @tag :bypass
    test "search failed", %{opencritic: opencritic} do
      expect_search_fail(opencritic)

      {:error,
       "HTTP status code: 429.\nAccessed url: [http://localhost:1237/game/search].\nParams were: %{criteria: \"Alan Wake II\"}\n"} =
        Client.find(%Game{name: "Alan Wake II"})
    end

    @tag :bypass
    test "game by id failed", %{opencritic: opencritic} do
      expect_search(opencritic, "The Witcher 3: Wild Hunt", "search_found")
      expect_game_by_id_fail(opencritic, "463")

      {:error,
       "HTTP status code: 429.\nAccessed url: [http://localhost:1237/game/463].\nParams were: %{}\n"} =
        Client.find(%Game{name: "The Witcher 3: Wild Hunt"})
    end

    @tag :bypass
    test "reviews failed", %{opencritic: opencritic} do
      expect_search(opencritic, "The Witcher 3: Wild Hunt", "search_found")
      expect_game_by_id(opencritic, "463", "witcher3")
      expect_reviews_fail(opencritic, "463")

      {:error,
       "HTTP status code: 429.\nAccessed url: [http://localhost:1237/review/game/463].\nParams were: %{}\n"} =
        Client.find(%Game{name: "The Witcher 3: Wild Hunt"})
    end
  end

  def expect_search(api, expected_criteria, fixture) do
    Bypass.expect_once(api, "GET", "/game/search", fn conn ->
      conn = Conn.fetch_query_params(conn)

      assert ["opencritic_api_key"] = Conn.get_req_header(conn, "x-rapidapi-key")
      assert ["opencritic-api.p.rapidapi.com"] = Conn.get_req_header(conn, "x-rapidapi-host")

      assert %{params: %{"criteria" => ^expected_criteria}} = conn

      Conn.resp(
        conn,
        200,
        File.read!("./test/support/fixtures/opencritic/#{fixture}.json")
      )
    end)
  end

  def expect_game_by_id(api, game_id, fixture) do
    Bypass.expect_once(api, "GET", "/game/#{game_id}", fn conn ->
      conn = Conn.fetch_query_params(conn)

      assert ["opencritic_api_key"] = Conn.get_req_header(conn, "x-rapidapi-key")
      assert ["opencritic-api.p.rapidapi.com"] = Conn.get_req_header(conn, "x-rapidapi-host")

      Conn.resp(
        conn,
        200,
        File.read!("./test/support/fixtures/opencritic/#{fixture}.json")
      )
    end)
  end

  def expect_reviews(api, game_id, fixture) do
    Bypass.expect_once(api, "GET", "/review/game/#{game_id}", fn conn ->
      conn = Conn.fetch_query_params(conn)

      assert ["opencritic_api_key"] = Conn.get_req_header(conn, "x-rapidapi-key")
      assert ["opencritic-api.p.rapidapi.com"] = Conn.get_req_header(conn, "x-rapidapi-host")

      Conn.resp(
        conn,
        200,
        File.read!("./test/support/fixtures/opencritic/#{fixture}.json")
      )
    end)
  end

  def expect_search_fail(api) do
    Bypass.expect(api, "GET", "/game/search", fn conn ->
      Conn.resp(conn, 429, "rate_limited")
    end)
  end

  def expect_game_by_id_fail(api, game_id) do
    Bypass.expect(api, "GET", "/game/#{game_id}", fn conn ->
      Conn.resp(conn, 429, "rate_limited")
    end)
  end

  def expect_reviews_fail(api, game_id) do
    Bypass.expect(api, "GET", "/review/game/#{game_id}", fn conn ->
      Conn.resp(conn, 429, "rate_limited")
    end)
  end
end
