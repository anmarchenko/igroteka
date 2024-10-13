defmodule SkaroWeb.ScreenshotController do
  use SkaroWeb, :controller

  alias Skaro.Core

  action_fallback(SkaroWeb.FallbackController)

  plug(Guardian.Plug.EnsureAuthenticated)

  @spec index(any, map) :: {:error, :external_api, any} | Plug.Conn.t()
  def index(conn, %{"game_id" => game_id}) do
    case Core.get_screenshots(game_id) do
      {:ok, screenshots} ->
        Tracer.set_attribute(:result, :ok)
        Tracer.set_status(OpenTelemetry.status(:ok, ""))

        render(conn, "index.json", screenshots: screenshots)

      {:error, reason} ->
        Tracer.set_attribute(:result, :external_api_failure)
        Tracer.set_status(OpenTelemetry.status(:error, "IGDB API failure: #{reason}"))

        {:error, :external_api, reason}
    end
  end
end
