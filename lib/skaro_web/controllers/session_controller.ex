defmodule SkaroWeb.SessionController do
  @moduledoc """
    Sign in and sign out controller
  """
  use SkaroWeb, :controller

  alias Skaro.Accounts.Sessions
  alias Skaro.Guardian
  alias Skaro.Guardian.Plug, as: GuardianPlug

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

  def delete(conn, _) do
    case GuardianPlug.current_token(conn) do
      nil ->
        {:error, :wrong_authentication}

      {:ok, token} ->
        Guardian.revoke(token)
        render(conn, "delete.json")
    end
  end

  def unauthenticated(conn, _) do
    conn
    |> put_status(:forbidden)
    |> render(SkaroWeb.SessionView, "forbidden.json", error: "Not Authenticated")
  end
end
