defmodule Skaro.Howlongtobeat.ClientTest do
  @moduledoc false
  use Skaro.DataCase

  alias Plug.Conn

  alias Skaro.Core.Game
  alias Skaro.Howlongtobeat.Client

  describe "find/1" do
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
              }} == Client.find(%Game{name: "Death Stranding", release_date: ~D[2019-11-08]})
    end

    @tag :bypass
    test "happy but not that obvious path", %{howlongtobeat: howlongtobeat} do
      Bypass.expect_once(
        howlongtobeat,
        "POST",
        "/search_results",
        fn conn ->
          {:ok, body, conn} = Conn.read_body(conn)

          assert "queryString=Doom&t=games&sorthead=popular&sortd=Normal+Order&length_type=main&page=1" ==
                   body

          Conn.resp(
            conn,
            200,
            File.read!("./test/support/fixtures/howlongtobeat_search_ambiguity.html")
          )
        end
      )

      Bypass.expect_once(
        howlongtobeat,
        "GET",
        "/game",
        fn conn ->
          conn = Conn.fetch_query_params(conn)
          assert "2701" == conn.params["id"]
          Conn.resp(conn, 200, File.read!("./test/support/fixtures/howlongtobeat_2708.html"))
        end
      )

      assert {:ok,
              %{
                external_id: "2701",
                external_url: "http://localhost:#{howlongtobeat.port}/game?id=2701",
                completionist: 1530,
                main: 690,
                main_extra: 960
              }} == Client.find(%Game{name: "Doom", release_date: ~D[1993-12-10]})
    end

    @tag :bypass
    test "game with no story mode", %{howlongtobeat: howlongtobeat} do
      Bypass.expect_once(
        howlongtobeat,
        "POST",
        "/search_results",
        fn conn ->
          {:ok, body, conn} = Conn.read_body(conn)

          assert "queryString=Overwatch&t=games&sorthead=popular&sortd=Normal+Order&length_type=main&page=1" ==
                   body

          Conn.resp(
            conn,
            200,
            File.read!("./test/support/fixtures/howlongtobeat_search.html")
          )
        end
      )

      Bypass.expect_once(
        howlongtobeat,
        "GET",
        "/game",
        fn conn ->
          Conn.resp(conn, 200, File.read!("./test/support/fixtures/howlongtobeat_31590.html"))
        end
      )

      assert {:error, "Times are not available"} ==
               Client.find(%Game{name: "Overwatch", release_date: ~D[2015-12-10]})
    end

    test "invalid arguments" do
      assert {:error, "name is not given"} ==
               Client.find(%Game{release_date: ~D[2015-12-10]})

      assert {:error, "release_date is not given"} ==
               Client.find(%Game{name: "Overwatch"})

      assert {:error, "argument is invalid"} ==
               Client.find(nil)
    end

    @tag :bypass
    test "API is down", %{howlongtobeat: howlongtobeat} do
      Bypass.down(howlongtobeat)

      assert {:error, :econnrefused} ==
               Client.find(%Game{name: "Overwatch", release_date: ~D[2015-12-10]})
    end

    @tag :bypass
    test "No games found", %{howlongtobeat: howlongtobeat} do
      Bypass.expect_once(
        howlongtobeat,
        "POST",
        "/search_results",
        fn conn ->
          Conn.resp(
            conn,
            200,
            File.read!("./test/support/fixtures/howlongtobeat_search_empty.html")
          )
        end
      )

      assert {:error, "Not found"} ==
               Client.find(%Game{name: "Overwatch", release_date: ~D[2015-12-10]})
    end

    @tag :bypass
    test "No games found with desired release date", %{howlongtobeat: howlongtobeat} do
      Bypass.expect_once(
        howlongtobeat,
        "POST",
        "/search_results",
        fn conn ->
          Conn.resp(
            conn,
            200,
            File.read!("./test/support/fixtures/howlongtobeat_search_ambiguity.html")
          )
        end
      )

      assert {:error, "Not found"} ==
               Client.find(%Game{name: "Doom", release_date: ~D[2019-12-10]})
    end

    @tag :bypass
    test "The game is not released yet", %{howlongtobeat: howlongtobeat} do
      Bypass.expect_once(
        howlongtobeat,
        "POST",
        "/search_results",
        fn conn ->
          Conn.resp(
            conn,
            200,
            File.read!("./test/support/fixtures/howlongtobeat_search.html")
          )
        end
      )

      Bypass.expect_once(
        howlongtobeat,
        "GET",
        "/game",
        fn conn ->
          Conn.resp(conn, 200, File.read!("./test/support/fixtures/howlongtobeat_2127.html"))
        end
      )

      assert {:error, "Times are not available"} ==
               Client.find(%Game{name: "Cyberpunk 2077", release_date: ~D[2020-09-17]})
    end

    @tag :bypass
    test "no game found", %{howlongtobeat: howlongtobeat} do
      Bypass.expect_once(
        howlongtobeat,
        "POST",
        "/search_results",
        fn conn ->
          Conn.resp(
            conn,
            200,
            File.read!("./test/support/fixtures/howlongtobeat_search_empty.html")
          )
        end
      )

      assert {:error, "Not found"} ==
               Client.find(%Game{name: "No such game", release_date: ~D[2020-09-17]})
    end
  end
end
