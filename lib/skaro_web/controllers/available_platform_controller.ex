defmodule SkarWeb.AvailablePlatformController do
  use SkaroWeb, :controller

  alias Skaro.Backlog.Entries
  alias Skaro.Guardian.Plug, as: GuardianPlug

  action_fallback(SkaroWeb.FallbackController)

  plug(Guardian.Plug.EnsureAuthenticated)

  def index(conn, %{"status" => status}) do
    res =
      conn
      |> GuardianPlug.current_resource()
      |> Entries.list_available_platforms(status)

    render(conn, "index.json", available_platforms: res)
  end

  def owned(conn, %{"status" => status}) do
    res =
      conn
      |> GuardianPlug.current_resource()
      |> Entries.list_owned_platforms(status)

    render(conn, "index.json", available_platforms: res)
  end
end
