defmodule SkaroWeb.PlaythroughTimeControllerTest do
  @moduledoc false
  use SkaroWeb.ConnCase

  alias Skaro.Playthrough.PlaythroughTime
  alias Skaro.Repo

  import Mox
  import Skaro.Factory

  setup :verify_on_exit!

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "GET :show" do
    @tag :login
    test "returns playthrough time from remote source", %{
      conn: conn
    } do
      Skaro.PlaythroughRemoteMock
      |> expect(:find, fn %{id: game_id, name: game_name, release_date: game_release_date} ->
        assert 42 = game_id
        assert "Warcraft" = game_name
        assert ~D[2001-12-11] = game_release_date

        {:ok,
         %{
           external_id: "1234",
           external_url: "http://website/1234",
           main: 60,
           main_extra: 120,
           completionist: 180
         }}
      end)

      conn =
        get(
          conn,
          Routes.playthrough_time_path(@endpoint, :show, 42,
            name: "Warcraft",
            release_date: "2001-12-11"
          )
        )

      json = json_response(conn, 200)

      assert %{
               "badge" => "very-short",
               "badge_label" => "Very short",
               "id" => id,
               "external_url" => "http://website/1234",
               "main" => 60,
               "main_extra" => 120,
               "completionist" => 180
             } = json

      assert Repo.get!(PlaythroughTime, id)
    end

    @tag :login
    test "returns playthrough time from local database", %{
      conn: conn
    } do
      insert(:playthrough_time, main: 372, game_id: 42, external_url: "http://test/games/42")

      conn =
        get(
          conn,
          Routes.playthrough_time_path(@endpoint, :show, 42,
            name: "Warcraft",
            release_date: "2001-12-11"
          )
        )

      json = json_response(conn, 200)

      assert %{
               "badge" => "short",
               "badge_label" => "Short",
               "id" => id,
               "main" => 372,
               "external_url" => "http://test/games/42"
             } = json

      assert Repo.get!(PlaythroughTime, id)
    end

    @tag :login
    test "error fetching data", %{
      conn: conn
    } do
      Skaro.PlaythroughRemoteMock
      |> expect(:find, fn _ ->
        {:error, :econnrefused}
      end)

      conn =
        get(
          conn,
          Routes.playthrough_time_path(@endpoint, :show, 42,
            name: "Warcraft",
            release_date: "2001-12-11"
          )
        )

      json = json_response(conn, 503)

      assert %{
               "error" => "external call failed"
             } = json
    end

    @tag :login
    test "not found", %{
      conn: conn
    } do
      Skaro.PlaythroughRemoteMock
      |> expect(:find, fn _ ->
        {:error, :not_found}
      end)

      conn =
        get(
          conn,
          Routes.playthrough_time_path(@endpoint, :show, 42,
            name: "Warcraft",
            release_date: "2001-12-11"
          )
        )

      json = json_response(conn, 404)

      assert %{
               "error" => "not found"
             } = json
    end

    @tag :login
    test "wrong date provided", %{
      conn: conn
    } do
      conn =
        get(
          conn,
          Routes.playthrough_time_path(@endpoint, :show, 42,
            name: "Warcraft",
            release_date: "2001-25-25"
          )
        )

      assert response(conn, 400)
    end

    @tag :login
    test "date is in the future", %{
      conn: conn
    } do
      conn =
        get(
          conn,
          Routes.playthrough_time_path(@endpoint, :show, 42,
            name: "Warcraft",
            release_date: Timex.format!(Timex.shift(Timex.today(), days: 1), "{YYYY}-{0M}-{D}")
          )
        )

      assert response(conn, 400)
    end

    @tag :login
    test "error database validation", %{
      conn: conn
    } do
      Skaro.PlaythroughRemoteMock
      |> expect(:find, fn _ ->
        {:ok,
         %{
           main: 60,
           main_extra: 120,
           completionist: 180
         }}
      end)

      conn =
        get(
          conn,
          Routes.playthrough_time_path(@endpoint, :show, 42,
            name: "Warcraft",
            release_date: "2001-12-11"
          )
        )

      json = json_response(conn, 422)

      assert %{
               "errors" => %{"external_id" => ["can't be blank"]}
             } = json
    end
  end
end
