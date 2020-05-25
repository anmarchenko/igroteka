defmodule SkaroWeb.GameControllerTest do
  @moduledoc false
  use SkaroWeb.ConnCase

  import Mox
  import Skaro.Factory

  setup :verify_on_exit!

  describe "GET :index" do
    setup do
      {:ok, game: build(:game)}
    end

    @tag :login
    test "external api call errored", %{conn: conn} do
      Skaro.GamesRemoteMock
      |> expect(:search, fn term ->
        assert "civilization" = term
        {:error, "Connection refused"}
      end)

      conn = get(conn, Routes.game_path(@endpoint, :index, term: "civilization"))

      json = json_response(conn, 503)
      assert json["error"] == "external call failed"

      cached_value =
        ConCache.get(
          :external_api_cache,
          "games_index_term_civilization_v1.0"
        )

      assert nil == cached_value
    end

    @tag :login
    test "external api call succeeded", %{conn: conn, game: game} do
      Skaro.GamesRemoteMock
      |> expect(:search, fn term ->
        assert "xcom" = term
        {:ok, [game]}
      end)

      conn = get(conn, Routes.game_path(@endpoint, :index, term: "xcom"))

      json = json_response(conn, 200)
      game_json = Enum.fetch!(json, 0)

      assert game_json["id"] == game.id
      assert game_json["name"] == game.name
      assert game_json["short_description"] == game.short_description
      assert game_json["release_date"] == game.release_date
      assert game_json["poster"]["thumb_url"] == game.cover.thumb_url

      platform_json = Enum.fetch!(game_json["platforms"], 0)
      platform = Enum.fetch!(game.platforms, 0)

      assert platform_json["id"] == platform.id
      assert platform_json["name"] == platform.name

      cached_value =
        ConCache.get(
          :external_api_cache,
          "games_index_term_xcom_v1.0"
        )

      assert [game] == cached_value
    end

    @tag :login
    test "requesting top games", %{conn: conn, game: game} do
      Skaro.GamesRemoteMock
      |> expect(:top_games, fn _ ->
        {:ok, [game]}
      end)

      conn = get(conn, Routes.game_path(@endpoint, :index))

      json = json_response(conn, 200)
      game_json = Enum.fetch!(json, 0)

      assert game_json["id"] == game.id
      assert game_json["name"] == game.name

      cached_value =
        ConCache.get(
          :external_api_cache,
          "games_index_top_year__platform_"
        )

      assert [game] == cached_value
    end

    @tag :login
    test "requesting top games with filter", %{conn: conn, game: game} do
      Skaro.GamesRemoteMock
      |> expect(:top_games, fn filters ->
        assert "2017" == filters["year"]
        assert "42" == filters["platform"]
        {:ok, [game]}
      end)

      conn = get(conn, Routes.game_path(@endpoint, :index, year: 2017, platform: 42))

      json = json_response(conn, 200)
      game_json = Enum.fetch!(json, 0)

      assert game_json["id"] == game.id

      cached_value =
        ConCache.get(
          :external_api_cache,
          "games_index_top_year_2017_platform_42"
        )

      assert [game] == cached_value
    end
  end

  describe "GET :show" do
    setup do
      {:ok, game: build(:game)}
    end

    @tag :login
    test "external api call errored", %{conn: conn} do
      Skaro.GamesRemoteMock
      |> expect(:find_one, fn id ->
        assert "453" = id
        {:error, "Object not found"}
      end)

      conn = get(conn, Routes.game_path(@endpoint, :show, 453))

      json = json_response(conn, 503)
      assert json["error"] == "external call failed"

      cached_value =
        ConCache.get(
          :external_api_cache,
          "games_show_453_v1.0"
        )

      assert nil == cached_value
    end

    @tag :login
    test "external api call succeeded", %{conn: conn, game: game} do
      Skaro.GamesRemoteMock
      |> expect(:find_one, fn id ->
        assert "2355" = id
        {:ok, game}
      end)

      conn = get(conn, Routes.game_path(@endpoint, :show, 2355))

      game_json = json_response(conn, 200)
      assert game_json["id"] == game.id
      assert game_json["name"] == game.name
      assert game_json["rating"] == game.rating
      assert game_json["ratings_count"] == game.ratings_count
      assert game_json["external_url"] == game.external_url

      {:ok, dev} = Enum.fetch(game_json["developers"], 0)
      assert dev["country"] == "US"
      assert dev["logo"]["id"] != nil

      cached_value =
        ConCache.get(
          :external_api_cache,
          "games_show_2355_v1.0"
        )

      assert game == cached_value
    end
  end
end
