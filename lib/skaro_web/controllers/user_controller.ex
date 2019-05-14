defmodule SkaroWeb.UserController do
  use SkaroWeb, :controller

  alias Skaro.Accounts.{User, Users}
  alias Skaro.Guardian.Plug, as: GuardianPlug
  alias Skaro.Repo

  require Logger

  action_fallback(SkaroWeb.FallbackController)

  plug(
    :scrub_params,
    "user"
    when action in [
           :update,
           :update_password
         ]
  )

  plug(Guardian.Plug.EnsureAuthenticated)

  def current(conn, _) do
    render(conn, "user_badge.json", user: GuardianPlug.current_resource(conn))
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.json", user: Users.get!(id))
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    with user <- Repo.get!(User, id),
         true <- authorized_to_edit?(conn, user),
         {:ok, user} <- Users.update_profile(user, user_params) do
      render(conn, "show.json", user: user)
    else
      false ->
        {:error, :forbidden}

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def update_password(conn, %{"id" => id, "user" => user_params}) do
    with user <- Repo.get!(User, id),
         true <- authorized_to_edit?(conn, user),
         {:ok, user} <- Users.update_password(user, user_params) do
      render(conn, "show.json", user: user)
    else
      false ->
        {:error, :forbidden}

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  defp authorized_to_edit?(conn, edited_user),
    do: edited_user.id == GuardianPlug.current_resource(conn).id
end
