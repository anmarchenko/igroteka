defmodule SkaroWeb.SessionController do
  @moduledoc """
    Sign in and sign out controller
  """
  use SkaroWeb, :controller

  alias Skaro.Accounts.Sessions

  action_fallback(SkaroWeb.FallbackController)

  plug(:scrub_params, "session" when action in [:create])

  def create(conn, %{"session" => session_params}) do
    case Sessions.authenticate(session_params) do
      {:ok, user, jwt} ->
        conn
        |> put_status(:created)
        |> render("show.json", jwt: jwt, user: user)

      {:error, _} ->
        {:error, :wrong_authentication}
    end
  end

  def unauthenticated(conn, _) do
    conn
    |> put_status(:forbidden)
    |> put_view(SkaroWeb.SessionView)
    |> render("forbidden.json", error: "Not Authenticated")
  end
end
