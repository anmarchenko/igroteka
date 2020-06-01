defmodule Skaro.Howlongtobeat.ClientTest do
  @moduledoc false
  use Skaro.DataCase

  alias Plug.Conn

  alias Skaro.Core.Game
  alias Skaro.Howlongtobeat.Client

  describe "fetch/1" do
    @tag :bypass
    test "happiest path", %{howlongtobeat: howlongtobeat} do
      Bypass.expect_once(
        howlongtobeat,
        "POST",
        "/search_results",
        fn conn ->
          {:ok, body, conn} = Conn.read_body(conn)

          assert "queryString=Death+Stranding&t=games&sorthead=popular&sortd=Normal+Order&length_type=main&page=1" ==
                   body

          Conn.resp(conn, 200, File.read!("./test/support/fixtures/howlongtobeat_search.html"))
        end
      )

      Bypass.expect_once(
        howlongtobeat,
        "GET",
        "/game",
        fn conn ->
          conn = Conn.fetch_query_params(conn)
          assert "38061" == conn.params["id"]
          Conn.resp(conn, 200, File.read!("./test/support/fixtures/howlongtobeat_38061.html"))
        end
      )

      assert {:ok,
              %{
                external_id: "38061",
                external_url: "http://localhost:#{howlongtobeat.port}/game?id=38061",
                completionist: 6780,
                main: 2400,
                main_extra: 3480
              }} == Client.fetch(%Game{name: "Death Stranding", release_date: ~D[2019-11-08]})
    end
  end
end
