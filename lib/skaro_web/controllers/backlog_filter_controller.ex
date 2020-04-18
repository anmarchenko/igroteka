defmodule SkaroWeb.BacklogFilterController do
  use SkaroWeb, :controller

  alias Skaro.Backlog.Entries
  alias Skaro.Guardian.Plug, as: GuardianPlug

  action_fallback(SkaroWeb.FallbackController)

  plug(Guardian.Plug.EnsureAuthenticated)

  @spec index(Plug.Conn.t(), map) :: Plug.Conn.t()
  def index(conn, %{"status" => status}) do
    with user <- GuardianPlug.current_resource(conn),
         platforms <- Entries.list_platforms_filter(user, status),
         years <- Entries.list_years_filter(user, status) do
      render(conn, "index.json", platforms: platforms, years: years)
    end
  end
end
