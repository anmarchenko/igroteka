defmodule SkaroWeb.AvailablePlatformControllerTest do
  @moduledoc false
  use SkaroWeb.ConnCase

  import Skaro.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "GET :index" do
    @tag :login
    test "returns all available platforms for backlog status for current_user", %{
      conn: conn,
      logged_user: user
    } do
      insert_list(2, :backlog_entry, user: user, status: "playing")

      conn =
        get(
          conn,
          Routes.available_platform_path(@endpoint, :index, status: "playing")
        )

      index_json = json_response(conn, 200)
      assert 4 == Enum.count(index_json)

      show_json = List.first(index_json)
      assert show_json["id"]
      assert show_json["name"]
    end
  end

  describe "GET :owned" do
    @tag :login
    test "returns all owned platforms for backlog status for current_user", %{
      conn: conn,
      logged_user: user
    } do
      insert(:backlog_entry,
        user: user,
        status: "backlog",
        owned_platform_id: 1,
        owned_platform_name: "PS4"
      )

      insert(:backlog_entry,
        user: user,
        status: "backlog",
        owned_platform_id: 2,
        owned_platform_name: "Switch"
      )

      insert(:backlog_entry,
        user: user,
        status: "backlog",
        owned_platform_id: 1,
        owned_platform_name: "PS4"
      )

      conn =
        get(
          conn,
          Routes.available_platform_path(@endpoint, :owned, status: "backlog")
        )

      index_json = json_response(conn, 200)
      assert 2 == Enum.count(index_json)

      show_json = List.first(index_json)
      assert show_json["id"]
      assert show_json["name"]
    end
  end
end
