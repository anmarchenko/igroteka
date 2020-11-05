defmodule SkaroWeb.ReviewControllerTest do
  @moduledoc false
  use SkaroWeb.ConnCase

  alias Skaro.Repo
  alias Skaro.Reviews.Rating

  import Mox
  import Skaro.Factory

  setup :verify_on_exit!

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "GET :show" do
    @tag :login
    test "returns rating from remote source", %{
      conn: conn
    } do
      Skaro.ReviewsRemoteMock
      |> expect(:find, fn %{id: game_id, name: game_name} ->
        assert 42 = game_id
        assert "Warcraft" = game_name

        {:ok,
         %{
           external_id: "1234",
           percent_recommended: 72.3,
           score: 79,
           num_reviews: 146,
           tier: "Strong",
           summary: "Pretty good game",
           points: [%{state: "pro", title: "Play as player", description: "Cool"}],
           reviews: [
             %{
               external_url: "https://critic/game",
               name: "Les Criticque",
               score: 80,
               snippet: "Dope"
             }
           ]
         }}
      end)

      conn =
        get(
          conn,
          Routes.review_path(@endpoint, :show, 42,
            name: "Warcraft",
            release_date: "2001-12-11"
          )
        )

      json = json_response(conn, 200)

      assert %{
               "external_id" => "1234",
               "percent_recommended" => 72.3,
               "id" => id,
               "score" => 79.0,
               "num_reviews" => 146,
               "tier" => "Strong",
               "summary" => "Pretty good game",
               "points" => [
                 %{"state" => "pro", "title" => "Play as player", "description" => "Cool"}
               ],
               "reviews" => [
                 %{
                   "external_url" => "https://critic/game",
                   "name" => "Les Criticque",
                   "score" => 80,
                   "snippet" => "Dope"
                 }
               ]
             } = json

      assert Repo.get!(Rating, id)
    end

    @tag :login
    test "returns rating from local database", %{
      conn: conn
    } do
      insert(:rating, score: 101, game_id: 42)

      conn =
        get(
          conn,
          Routes.review_path(@endpoint, :show, 42,
            name: "Warcraft",
            release_date: "2001-12-11"
          )
        )

      json = json_response(conn, 200)

      assert %{
               "id" => id,
               "score" => 101.0
             } = json

      assert Repo.get!(Rating, id)
    end

    @tag :login
    test "error fetching data", %{
      conn: conn
    } do
      Skaro.ReviewsRemoteMock
      |> expect(:find, fn _ ->
        {:error, :econnrefused}
      end)

      conn =
        get(
          conn,
          Routes.review_path(@endpoint, :show, 42,
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
    test "wrong date provided", %{
      conn: conn
    } do
      conn =
        get(
          conn,
          Routes.review_path(@endpoint, :show, 42,
            name: "Warcraft",
            release_date: "2001-25-25"
          )
        )

      assert response(conn, 400)
    end

    @tag :login
    test "error database validation", %{
      conn: conn
    } do
      Skaro.ReviewsRemoteMock
      |> expect(:find, fn _ ->
        {:ok,
         %{
           score: 1
         }}
      end)

      conn =
        get(
          conn,
          Routes.review_path(@endpoint, :show, 42,
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
