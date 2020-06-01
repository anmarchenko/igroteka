defmodule Skaro.GiantbombTest do
  @moduledoc false
  use Skaro.DataCase

  alias Plug.Conn

  alias Skaro.Giantbomb
  alias Skaro.Core.{Game, Image, Platform}

  describe "Giantbomb.search/1" do
    @tag :bypass
    test "malformed json", %{bypass: bypass} do
      Bypass.expect_once(
        bypass,
        "GET",
        "/search/",
        fn conn ->
          Conn.resp(conn, 200, "nope, this is not json, just plain text")
        end
      )

      assert {
               :error,
               "Invalid json: nope, this is not json, just plain text"
             } == Giantbomb.search("game query")
    end

    @tag :bypass
    test "server error", %{bypass: bypass} do
      Bypass.down(bypass)

      assert {:error, :econnrefused} == Giantbomb.search("term")
    end

    @tag :bypass
    test "not authorized", %{bypass: bypass} do
      Bypass.expect(
        bypass,
        "GET",
        "/search/",
        fn conn ->
          conn = Conn.fetch_query_params(conn)
          assert "giantbomb_api_key" = conn.params["api_key"]

          assert "deck,name,id,image,original_release_date,platforms" = conn.params["field_list"]

          assert "json" = conn.params["format"]
          assert "xcom" = conn.params["query"]
          assert "game" = conn.params["resources"]

          Conn.resp(conn, 401, """
          {
            error: "Invalid API Key",
            limit: 0,
            offset: 0,
            number_of_page_results: 0,
            number_of_total_results: 0,
            status_code: 100,
            results: [ ]
          }
          """)
        end
      )

      expected_params = %{
        "api_key" => "giantbomb_api_key",
        "field_list" => "deck,name,id,image,original_release_date,platforms",
        "format" => "json",
        "query" => "xcom",
        "resources" => "game"
      }

      assert {:error,
              """
              HTTP status code: 401.
              Accessed url: [http://localhost:#{bypass.port}/search/].
              Params were: #{inspect(expected_params)}
              """} == Giantbomb.search("xcom")
    end

    @tag :bypass
    test "ok response", %{bypass: bypass} do
      Bypass.expect_once(
        bypass,
        "GET",
        "/search/",
        fn conn ->
          conn = Conn.fetch_query_params(conn)
          assert "giantbomb_api_key" = conn.params["api_key"]

          assert "deck,name,id,image,original_release_date,platforms" = conn.params["field_list"]

          assert "json" = conn.params["format"]
          assert "civilization" = conn.params["query"]
          assert "game" = conn.params["resources"]

          Conn.resp(conn, 200, """
          {
            "error": "OK",
            "limit": 10,
            "offset": 0,
            "number_of_page_results": 2,
            "number_of_total_results": 61,
            "status_code": 1,
            "results": [
              {
                "deck": "Civilization III is the third installment of Sid Meier's franchise and brings many new features including unique units and traits for each civilization, culture, and improved combat and graphics.",
                "id": 1594,
                "image": {
                  "icon_url": "https://www.giantbomb.com/api/image/square_avatar/625303-454261_27064_front_1_.jpg",
                  "medium_url": "https://www.giantbomb.com/api/image/scale_medium/625303-454261_27064_front_1_.jpg",
                  "screen_url": "https://www.giantbomb.com/api/image/screen_medium/625303-454261_27064_front_1_.jpg",
                  "small_url": "https://www.giantbomb.com/api/image/scale_small/625303-454261_27064_front_1_.jpg",
                  "super_url": "https://www.giantbomb.com/api/image/scale_large/625303-454261_27064_front_1_.jpg",
                  "thumb_url": "https://www.giantbomb.com/api/image/scale_avatar/625303-454261_27064_front_1_.jpg",
                  "tiny_url": "https://www.giantbomb.com/api/image/square_mini/625303-454261_27064_front_1_.jpg"
                },
                "name": "Sid Meier's Civilization III",
                "original_release_date": "2001-10-30 00:00:00",
                "platforms": [
                  {
                      "api_detail_url": "https://www.giantbomb.com/api/platform/3045-17/",
                      "id": 17,
                      "name": "Mac",
                      "site_detail_url": "https://www.giantbomb.com/mac/3045-17/",
                      "abbreviation": "MAC"
                  },
                  {
                    "api_detail_url": "https://www.giantbomb.com/api/platform/3045-94/",
                    "id": 94,
                    "name": "PC",
                    "site_detail_url": "https://www.giantbomb.com/pc/3045-94/",
                    "abbreviation": "PC"
                  }
                ],
                "resource_type": "game"
              },
              {
                "deck": "The second game in the famous turn based strategy series by Sid Meier.",
                "id": 217,
                "image": {
                  "icon_url": "https://www.giantbomb.com/api/image/square_avatar/680940-civilization_2.png",
                  "medium_url": "https://www.giantbomb.com/api/image/scale_medium/680940-civilization_2.png",
                  "screen_url": "https://www.giantbomb.com/api/image/screen_medium/680940-civilization_2.png",
                  "small_url": "https://www.giantbomb.com/api/image/scale_small/680940-civilization_2.png",
                  "super_url": "https://www.giantbomb.com/api/image/scale_large/680940-civilization_2.png",
                  "thumb_url": "https://www.giantbomb.com/api/image/scale_avatar/680940-civilization_2.png",
                  "tiny_url": "https://www.giantbomb.com/api/image/square_mini/680940-civilization_2.png"
                },
                "name": "Sid Meier's Civilization II",
                "original_release_date": "1996-02-29 00:00:00",
                "platforms": [
                  {
                    "api_detail_url": "https://www.giantbomb.com/api/platform/3045-17/",
                    "id": 17,
                    "name": "Mac",
                    "site_detail_url": "https://www.giantbomb.com/mac/3045-17/",
                    "abbreviation": "MAC"
                  },
                  {
                    "api_detail_url": "https://www.giantbomb.com/api/platform/3045-22/",
                    "id": 22,
                    "name": "PlayStation",
                    "site_detail_url": "https://www.giantbomb.com/playstation/3045-22/",
                    "abbreviation": "PS1"
                  }
                ],
                "resource_type": "game"
              }
            ],
            "version": "1.0"
          }
          """)
        end
      )

      expected_games = [
        %Game{
          id: 1594,
          external_id: 1594,
          name: "Sid Meier's Civilization III",
          short_description:
            "Civilization III is the third installment of Sid Meier's franchise and brings many new features including unique units and traits for each civilization, culture, and improved combat and graphics.",
          release_date: "2001-10-30 00:00:00",
          cover: %Image{
            id: nil,
            big_url:
              "https://www.giantbomb.com/api/image/scale_medium/625303-454261_27064_front_1_.jpg",
            thumb_url:
              "https://www.giantbomb.com/api/image/scale_avatar/625303-454261_27064_front_1_.jpg"
          },
          platforms: [
            %Platform{
              id: 17,
              external_id: 17,
              name: "Mac"
            },
            %Platform{
              id: 94,
              external_id: 94,
              name: "PC"
            }
          ]
        },
        %Game{
          id: 217,
          external_id: 217,
          name: "Sid Meier's Civilization II",
          short_description:
            "The second game in the famous turn based strategy series by Sid Meier.",
          release_date: "1996-02-29 00:00:00",
          cover: %Image{
            id: nil,
            big_url: "https://www.giantbomb.com/api/image/scale_medium/680940-civilization_2.png",
            thumb_url:
              "https://www.giantbomb.com/api/image/scale_avatar/680940-civilization_2.png"
          },
          platforms: [
            %Platform{
              id: 17,
              external_id: 17,
              name: "Mac"
            },
            %Platform{
              id: 22,
              external_id: 22,
              name: "PlayStation"
            }
          ]
        }
      ]

      assert {:ok, expected_games} == Giantbomb.search("civilization")
    end
  end

  describe "Giantbomb.find_one/1" do
    @tag :bypass
    test "ok response", %{bypass: bypass} do
      Bypass.expect_once(
        bypass,
        "GET",
        "/game/37152/",
        fn conn ->
          conn = Conn.fetch_query_params(conn)
          assert "giantbomb_api_key" = conn.params["api_key"]

          assert "deck,name,id,image,original_release_date,platforms," <>
                   "description,images,developers,publishers,franchises,genres,themes" =
                   conn.params["field_list"]

          assert "json" = conn.params["format"]

          Conn.resp(conn, 200, """
          {
            "error": "OK",
            "limit": 10,
            "offset": 0,
            "number_of_page_results": 1,
            "number_of_total_results": 1,
            "status_code": 1,
            "results":
              {
                "deck": "The classic tactical turn-based combat returns in this modern re-imagining of X-COM: UFO Defense.",
                "id": 37152,
                "name": "X-COM: Enemy Unknown",
                "original_release_date": "2001-10-30 00:00:00",
                "resource_type": "game"
              },
            "version": "1.0"
          }
          """)
        end
      )

      assert {:ok, game} = Giantbomb.find_one(37_152)
      assert game.id == 37_152
    end

    @tag :bypass
    test "not found", %{bypass: bypass} do
      Bypass.expect_once(
        bypass,
        "GET",
        "/game/432432432/",
        fn conn ->
          conn = Conn.fetch_query_params(conn)

          Conn.resp(conn, 200, """
          {
            "error": "Object not found",
            "limit": 0,
            "offset": 0,
            "number_of_page_results": 0,
            "number_of_total_results": 0,
            "status_code": 100,
            "results": [ ]
          }
          """)
        end
      )

      assert {:error, "Object not found"} == Giantbomb.find_one(432_432_432)
    end
  end
end
