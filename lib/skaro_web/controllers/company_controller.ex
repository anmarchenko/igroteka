defmodule SkaroWeb.CompanyController do
  use SkaroWeb, :controller

  alias Skaro.Core

  action_fallback(SkaroWeb.FallbackController)

  plug(Guardian.Plug.EnsureAuthenticated)

  @spec show(any, map) :: {:error, :external_api, any} | Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    id
    |> Core.get_company()
    |> respond(conn)
  end

  defp respond({:ok, company}, conn) do
    render(conn, "show.json", company: company)
  end

  defp respond({:error, reason}, _) do
    {:error, :external_api, reason}
  end
end
