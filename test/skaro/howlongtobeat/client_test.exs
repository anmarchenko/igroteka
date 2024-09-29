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
        "/api/search/21fda17e4a1d49be",
        fn conn ->
          {:ok, body, conn} = Conn.read_body(conn)

          json = Jason.decode!(body)
          assert ["Death", "Stranding"] == json["searchTerms"]

          Conn.resp(conn, 200, File.read!("./test/support/fixtures/howlongtobeat_search.json"))
        end
      )

      Bypass.expect_once(
        howlongtobeat,
        "GET",
        "/game/38061",
        fn conn ->
          Conn.resp(conn, 200, File.read!("./test/support/fixtures/howlongtobeat_38061.html"))
        end
      )

      assert {:ok,
              %{
                external_id: "38061",
                external_url: "http://localhost:#{howlongtobeat.port}/game/38061",
                completionist: 6780,
                main: 2430,
                main_extra: 3570
              }} == Client.find(%Game{name: "Death Stranding", release_date: ~D[2019-11-08]})
    end

    @tag :bypass
    test "happy but not that obvious path", %{howlongtobeat: howlongtobeat} do
      Bypass.expect_once(
        howlongtobeat,
        "POST",
        "/api/search/21fda17e4a1d49be",
        fn conn ->
          {:ok, body, conn} = Conn.read_body(conn)

          json = Jason.decode!(body)
          assert ["Doom"] == json["searchTerms"]

          Conn.resp(
            conn,
            200,
            File.read!("./test/support/fixtures/howlongtobeat_search_ambiguity.json")
          )
        end
      )

      Bypass.expect_once(
        howlongtobeat,
        "GET",
        "/game/2701",
        fn conn ->
          Conn.resp(conn, 200, File.read!("./test/support/fixtures/howlongtobeat_2708.html"))
        end
      )

      assert {:ok,
              %{
                external_id: "2701",
                external_url: "http://localhost:#{howlongtobeat.port}/game/2701",
                completionist: 1590,
                main: 690,
                main_extra: 960
              }} == Client.find(%Game{name: "Doom", release_date: ~D[1993-12-10]})
    end

    @tag :bypass
    test "game with no story mode", %{howlongtobeat: howlongtobeat} do
      Bypass.expect_once(
        howlongtobeat,
        "POST",
        "/api/search/21fda17e4a1d49be",
        fn conn ->
          {:ok, body, conn} = Conn.read_body(conn)

          json = Jason.decode!(body)
          assert ["Overwatch"] == json["searchTerms"]

          Conn.resp(
            conn,
            200,
            File.read!("./test/support/fixtures/howlongtobeat_overwatch.json")
          )
        end
      )

      Bypass.expect_once(
        howlongtobeat,
        "GET",
        "/game/31590",
        fn conn ->
          Conn.resp(conn, 200, File.read!("./test/support/fixtures/howlongtobeat_31590.html"))
        end
      )

      assert {:error, :times_not_available} ==
               Client.find(%Game{name: "Overwatch", release_date: ~D[2016-12-10]})
    end

    test "invalid arguments" do
      assert {:error, :no_name} ==
               Client.find(%Game{release_date: ~D[2015-12-10]})

      assert {:error, :no_date} ==
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
        "/api/search/21fda17e4a1d49be",
        fn conn ->
          Conn.resp(
            conn,
            200,
            File.read!("./test/support/fixtures/howlongtobeat_search_empty.json")
          )
        end
      )

      assert {:error, :not_found} ==
               Client.find(%Game{name: "Overwatch", release_date: ~D[2015-12-10]})
    end

    @tag :bypass
    test "No games found with desired release date", %{howlongtobeat: howlongtobeat} do
      Bypass.expect_once(
        howlongtobeat,
        "POST",
        "/api/search/21fda17e4a1d49be",
        fn conn ->
          Conn.resp(
            conn,
            200,
            File.read!("./test/support/fixtures/howlongtobeat_search_ambiguity.json")
          )
        end
      )

      assert {:error, :not_found} ==
               Client.find(%Game{name: "Doom", release_date: ~D[2019-12-10]})
    end

    @tag :bypass
    test "The game is not released yet", %{howlongtobeat: howlongtobeat} do
      Bypass.expect_once(
        howlongtobeat,
        "POST",
        "/api/search/21fda17e4a1d49be",
        fn conn ->
          Conn.resp(
            conn,
            200,
            File.read!("./test/support/fixtures/howlongtobeat_not_released.json")
          )
        end
      )

      Bypass.expect_once(
        howlongtobeat,
        "GET",
        "/game/72589",
        fn conn ->
          Conn.resp(conn, 200, File.read!("./test/support/fixtures/howlongtobeat_72589.html"))
        end
      )

      assert {:error, :times_not_available} ==
               Client.find(%Game{
                 name: "The Legend of zelda: Tears of the Kingdom",
                 release_date: ~D[2023-12-31]
               })
    end

    @tag :bypass
    test "no game found", %{howlongtobeat: howlongtobeat} do
      Bypass.expect_once(
        howlongtobeat,
        "POST",
        "/api/search/21fda17e4a1d49be",
        fn conn ->
          Conn.resp(
            conn,
            200,
            File.read!("./test/support/fixtures/howlongtobeat_search_empty.json")
          )
        end
      )

      assert {:error, :not_found} ==
               Client.find(%Game{name: "No such game", release_date: ~D[2020-09-17]})
    end
  end
end
