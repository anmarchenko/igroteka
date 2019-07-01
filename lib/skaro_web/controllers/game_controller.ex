defmodule SkaroWeb.GameController do
  use SkaroWeb, :controller

  alias Skaro.Core

  action_fallback(SkaroWeb.FallbackController)

  plug(Guardian.Plug.EnsureAuthenticated)

  def index(conn, %{"term" => term}) do
    case Core.search(term) do
      {:ok, games} ->
        render(conn, "index.json", games: games)

      {:error, reason} ->
        {:error, :external_api, reason}
    end
  end

  def show(conn, %{"id" => id}) do
    case Core.get(id) do
      {:ok, game} ->
        render(conn, "show.json", game: game)

      {:error, reason} ->
        {:error, :external_api, reason}
    end
  end
end