defmodule SkaroWeb.FallbackController do
  use SkaroWeb, :controller

  require Logger

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(SkaroWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, :forbidden}) do
    conn
    |> put_status(:forbidden)
    |> put_view(SkaroWeb.ErrorView)
    |> render("forbidden.json")
  end

  def call(conn, {:error, :wrong_authentication}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(SkaroWeb.SessionView)
    |> render("error.json")
  end

  def call(conn, {:error, :external_api, reason}) do
    Logger.error("Call to external API failed. Reason was: [#{reason}]")

    conn
    |> put_status(:service_unavailable)
    |> put_view(SkaroWeb.ErrorView)
    |> render("external_error.json")
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(SkaroWeb.ErrorView)
    |> render("not_found.json")
  end

  def call(conn, {:error, :bad_request}), do: send_resp(conn, :bad_request, "")
end
