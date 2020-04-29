defmodule SkaroWeb.BacklogEntryControllerTest do
  @moduledoc false
  use SkaroWeb.ConnCase

  import Skaro.Factory

  alias Skaro.Backlog.Entry
  alias Skaro.Repo

  @platforms [%{platform_id: 42, platform_name: "PC"}]
  @valid_attrs %{game_id: 1234, game_name: "game name", status: "wishlist"}
  @invalid_attrs %{game_id: 1234, game_name: "game name", status: "wrong"}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "GET :index" do
    @tag :login
    test "returns all backlog entries for given filter for current user", %{
      conn: conn,
      logged_user: user
    } do
      insert_list(3, :backlog_entry, user: user, status: "backlog", expectation_rating: 3)
      insert_list(2, :backlog_entry, user: user, status: "playing")

      conn =
        get(
          conn,
          Routes.backlog_entry_path(
            @endpoint,
            :index,
            filters: %{"status" => "backlog"}
          )
        )

      index_json = json_response(conn, 200)

      assert 1 == index_json["meta"]["total_pages"]
      assert 1 == index_json["meta"]["page"]
      assert 3 == index_json["meta"]["total_count"]

      assert 3 == Enum.count(index_json["data"])

      show_json = List.first(index_json["data"])
      assert show_json["id"]
      assert show_json["game_id"]
      assert show_json["game_name"]
      assert show_json["available_platforms"]
      assert show_json["expectation_rating"]
    end

    @tag :login
    test "returns backlog entries filtered by year", %{
      conn: conn,
      logged_user: user
    } do
      insert_list(2, :backlog_entry,
        user: user,
        status: "backlog",
        game_release_date: ~D[2017-12-31]
      )

      insert(:backlog_entry, user: user, status: "backlog", game_release_date: ~D[2018-01-01])
      insert(:backlog_entry, user: user, status: "backlog", game_release_date: ~D[2018-12-31])
      insert(:backlog_entry, user: user, status: "backlog", game_release_date: ~D[2018-04-13])

      insert_list(6, :backlog_entry,
        user: user,
        status: "backlog",
        game_release_date: ~D[2019-01-01]
      )

      conn =
        get(
          conn,
          Routes.backlog_entry_path(
            @endpoint,
            :index,
            filters: %{"status" => "backlog", "release_year" => "2018"}
          )
        )

      index_json = json_response(conn, 200)

      assert 1 == index_json["meta"]["total_pages"]
      assert 1 == index_json["meta"]["page"]
      assert 3 == index_json["meta"]["total_count"]

      assert 3 == Enum.count(index_json["data"])

      show_json = List.first(index_json["data"])
      assert show_json["id"]
      assert show_json["game_id"]
      assert show_json["game_name"]
    end
  end

  describe "GET :show" do
    @tag :login
    test "renders given backlog_entry for current_user", %{conn: conn, logged_user: user} do
      entry = insert(:backlog_entry, user: user, expectation_rating: 1)
      conn = get(conn, Routes.backlog_entry_path(@endpoint, :show, entry.game_id))
      json = json_response(conn, 200)
      assert json["id"] == entry.id
      assert json["game_id"] == entry.game_id
      assert json["game_name"] == entry.game_name
      assert json["expectation_rating"] === 1
    end

    @tag :login
    test "renders not found when entry does not exist", %{conn: conn} do
      user = insert(:user)
      insert(:backlog_entry, user: user)

      assert_error_sent(404, fn ->
        get(conn, Routes.backlog_entry_path(@endpoint, :show, -1, user_id: user.id))
      end)
    end
  end

  describe "POST :create" do
    @tag :login
    test "valid attrs", %{conn: conn, logged_user: user} do
      conn =
        post(
          conn,
          Routes.backlog_entry_path(@endpoint, :create),
          backlog_entry: @valid_attrs,
          platforms: @platforms
        )

      show_json = json_response(conn, 201)
      assert show_json["game_id"] == @valid_attrs.game_id

      entry =
        Entry
        |> Repo.get!(show_json["id"])
        |> Repo.preload([:available_platforms])

      assert 1 == Enum.count(entry.available_platforms)
      assert @valid_attrs.status == entry.status
      assert user.id == entry.user_id
    end

    @tag :login
    test "invalid status params", %{conn: conn} do
      conn =
        post(
          conn,
          Routes.backlog_entry_path(@endpoint, :create),
          backlog_entry: @invalid_attrs,
          platforms: @platforms
        )

      assert json_response(conn, 422)["errors"] != %{}
    end

    @tag :login
    test "does not allow to create entry for arbitrary user", %{
      conn: conn,
      logged_user: user
    } do
      another_user = insert(:user)

      conn =
        post(
          conn,
          Routes.backlog_entry_path(@endpoint, :create),
          backlog_entry: Map.merge(@valid_attrs, %{user_id: another_user.id}),
          platforms: @platforms
        )

      assert json_response(conn, 201)["id"]
      entry = Repo.get_by(Entry, @valid_attrs)
      assert entry
      assert entry.user_id == user.id
    end

    test "not logged in", %{conn: conn} do
      conn = post(conn, Routes.backlog_entry_path(@endpoint, :create), post: @valid_attrs)
      assert response(conn, 401)
    end
  end

  describe "PUT :update" do
    @tag :login
    test "updates when attrs are valid and editing own entry", %{
      conn: conn,
      logged_user: user
    } do
      entry = insert(:backlog_entry, user: user)

      conn =
        put(
          conn,
          Routes.backlog_entry_path(@endpoint, :update, entry.game_id),
          backlog_entry: %{"status" => "backlog", "note" => "just bought on PS4"}
        )

      assert json_response(conn, 200)["id"]
      updated_entry = Repo.get!(Entry, entry.id)

      assert "backlog" == updated_entry.status
      assert "just bought on PS4" == updated_entry.note
    end

    @tag :login
    test "returns error when attrs are wrong", %{conn: conn, logged_user: user} do
      entry = insert(:backlog_entry, user: user)

      conn =
        put(
          conn,
          Routes.backlog_entry_path(@endpoint, :update, entry.game_id),
          backlog_entry: %{"status" => "custom"}
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "DELETE :delete" do
    @tag :login
    test "deletes chosen entry for user", %{conn: conn, logged_user: user} do
      entry = insert(:backlog_entry, user: user)
      conn = delete(conn, Routes.backlog_entry_path(@endpoint, :delete, entry.game_id))
      assert response(conn, 204)
      refute Repo.get(Entry, entry.id)
    end
  end
end
