defmodule SkaroWeb.BacklogFilterControllerTest do
  @moduledoc false
  use SkaroWeb.ConnCase

  import Skaro.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "GET :index" do
    @tag :login
    test "returns all filter values for backlog status for current_user", %{
      conn: conn,
      logged_user: user
    } do
      insert(:backlog_entry,
        user: user,
        status: "backlog",
        owned_platform_id: 1,
        owned_platform_name: "PS4",
        game_release_date: ~D[2019-02-12]
      )

      insert(:backlog_entry,
        user: user,
        status: "backlog",
        owned_platform_id: 2,
        owned_platform_name: "Switch",
        game_release_date: ~D[2017-08-03]
      )

      insert(:backlog_entry,
        user: user,
        status: "backlog",
        owned_platform_id: 1,
        owned_platform_name: "PS4",
        game_release_date: ~D[2018-12-31]
      )

      conn =
        get(
          conn,
          Routes.backlog_filter_path(@endpoint, :index, status: "backlog")
        )

      json = json_response(conn, 200)

      assert [2019, 2018, 2017] = json["years"]

      assert 2 == Enum.count(json["platforms"])

      show_json = List.first(json["platforms"])
      assert show_json["id"] == 1
      assert show_json["name"] == "PS4"
    end
  end
end
