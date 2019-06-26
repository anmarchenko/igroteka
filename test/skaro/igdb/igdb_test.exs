defmodule Skaro.IGDBTest do
  @moduledoc false
  use Skaro.DataCase

  alias Plug.Conn

  alias Skaro.Core.Game
  alias Skaro.IGDB

  describe "search/1" do
    @tag :bypass
    test "ok response", %{igdb_api: igdb_api} do
      Bypass.expect_once(
        igdb_api,
        "POST",
        "/search",
        fn conn ->
          assert ["igdb_api_key"] = Conn.get_req_header(conn, "user-key")
          assert {:ok, "search \"warcraft\";" <> _, conn} = Conn.read_body(conn)

          Conn.resp(conn, 200, """
          [
            {
              "game": {
                "aggregated_rating": 92.5,
                "aggregated_rating_count": 1,
                "cover": {
                  "id": 129,
                  "image_id": "olpk2nfqu4susanmykqu"
                },
                "first_release_date": 818467200,
                "id": 130,
                "name": "Warcraft II: Tides of Darkness",
                "platforms": [
                  {"id": 6, "name": "PC (Microsoft Windows)"},
                  {"id": 7, "name": "PlayStation"},
                  {"id": 13, "name": "PC DOS"},
                  {"id": 14, "name": "Mac"},
                  {"id": 32, "name": "Sega Saturn"}
                ],
                "summary": "Warcraft 2 is a successor of the popular Warcraft real-time strategy game. The game contains many improvements over the previous version in graphics, sounds and playability."
              },
              "id": 94347
            },
            {
              "game": {
                "aggregated_rating": 93.0,
                "aggregated_rating_count": 4,
                "cover": {
                  "id": 63923,
                  "image_id": "ad2vrrlzdsfy3s2fjtgv"
                },
                "first_release_date": 1025654400,
                "id": 132,
                "name": "Warcraft III: Reign of Chaos",
                "platforms": [
                  {"id": 6, "name": "PC (Microsoft Windows)"},
                  {"id": 14, "name": "Mac"}
                ],
                "summary": "Warcraft 3: Reign of Chaos is an RTS made by Blizzard Entertainment. Take control of either the Humans, the Orcs, the Night Elves or the Undead, all with different unit types and heroes with unique abilities."
              },
              "id": 99466
            }
          ]
          """)
        end
      )

      expected_games = [
        %Game{
          external_id: 130,
          name: "Warcraft II: Tides of Darkness",
          short_description:
            "Warcraft 2 is a successor of the popular Warcraft real-time strategy game. The game contains many improvements over the previous version in graphics, sounds and playability.",
          release_date: DateTime.from_naive!(~N[1995-12-09 00:00:00], "Etc/UTC"),
          rating: 92.5,
          ratings_count: 1
        },
        %Game{
          external_id: 132,
          name: "Warcraft III: Reign of Chaos",
          short_description:
            "Warcraft 3: Reign of Chaos is an RTS made by Blizzard Entertainment. Take control of either the Humans, the Orcs, the Night Elves or the Undead, all with different unit types and heroes with unique abilities.",
          release_date: DateTime.from_naive!(~N[2002-07-03 00:00:00], "Etc/UTC"),
          rating: 93.0,
          ratings_count: 4
        }
      ]

      assert {:ok, expected_games} == IGDB.search("warcraft")
    end

    @tag :bypass
    test "no connection", %{igdb_api: igdb_api} do
      Bypass.down(igdb_api)

      assert {:error, :econnrefused} == IGDB.search("term")
    end

    @tag :bypass
    test "internal IGDB error", %{igdb_api: igdb_api} do
      Bypass.expect_once(
        igdb_api,
        "POST",
        "/search",
        fn conn ->
          Conn.resp(conn, 200, """
          [
            {
              "status": "400",
              "title": "Bad request"
            }
          ]
          """)
        end
      )

      assert {:error, "Code 400, reason: Bad request"} == IGDB.search("term")
    end
  end
end
