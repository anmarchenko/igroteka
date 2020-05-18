defmodule SkaroWeb.ScreenshotControllerTest do
  @moduledoc false
  use SkaroWeb.ConnCase

  alias Skaro.Core.Image

  import Mox

  setup :verify_on_exit!

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "GET :index" do
    @tag :login
    test "returns all screenshots for given game_id", %{
      conn: conn
    } do
      Skaro.GamesRemoteMock
      |> expect(:get_screenshots, fn id ->
        assert "42" = id

        {:ok,
         [
           %Image{
             big_url: "https://images.igdb.com/igdb/image/upload/t_screenshot_huge_2x/image1.jpg",
             id: "i1oynuvf858i7g9nw5vk",
             thumb_url: "https://images.igdb.com/igdb/image/upload/t_screenshot_med_2x/image1.jpg"
           },
           %Image{
             big_url: "https://images.igdb.com/igdb/image/upload/t_screenshot_huge_2x/image2.jpg",
             id: "i1oynuvf858i7g9nw5vk",
             thumb_url: "https://images.igdb.com/igdb/image/upload/t_screenshot_med_2x/image2.jpg"
           }
         ]}
      end)

      conn =
        get(
          conn,
          Routes.screenshot_path(@endpoint, :index, game_id: "42")
        )

      json = json_response(conn, 200)

      assert [
               %{
                 "original" =>
                   "https://images.igdb.com/igdb/image/upload/t_screenshot_huge_2x/image1.jpg",
                 "thumbnail" =>
                   "https://images.igdb.com/igdb/image/upload/t_screenshot_med_2x/image1.jpg"
               },
               %{
                 "original" =>
                   "https://images.igdb.com/igdb/image/upload/t_screenshot_huge_2x/image2.jpg",
                 "thumbnail" =>
                   "https://images.igdb.com/igdb/image/upload/t_screenshot_med_2x/image2.jpg"
               }
             ] = json
    end
  end
end
