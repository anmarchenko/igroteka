defmodule SkaroWeb.ScreenshotController do
  use SkaroWeb, :controller

  alias Skaro.Core

  action_fallback(SkaroWeb.FallbackController)

  plug(Guardian.Plug.EnsureAuthenticated)

  @spec index(any, map) :: {:error, :external_api, any} | Plug.Conn.t()
  def index(conn, %{"game_id" => game_id}) do
    case Core.get_screenshots(game_id) do
      {:ok, screenshots} ->
        render(conn, "index.json", screenshots: screenshots)

      {:error, reason} ->
        {:error, :external_api, reason}
    end
  end
end
