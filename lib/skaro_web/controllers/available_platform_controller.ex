defmodule SkaroWeb.AvailablePlatformController do
  use SkaroWeb, :controller

  alias Skaro.Backlog.Entries
  alias Skaro.Guardian.Plug, as: GuardianPlug

  action_fallback(SkaroWeb.FallbackController)

  plug(Guardian.Plug.EnsureAuthenticated)

  @spec owned(Plug.Conn.t(), map) :: Plug.Conn.t()
  def owned(conn, %{"status" => status}) do
    res =
      conn
      |> GuardianPlug.current_resource()
      |> Entries.list_platforms_filter(status)

    render(conn, "index.json", available_platforms: res)
  end
end
