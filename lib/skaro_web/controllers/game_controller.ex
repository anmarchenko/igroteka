defmodule SkaroWeb.GameController do
  use SkaroWeb, :controller

  alias Skaro.Core

  action_fallback(SkaroWeb.FallbackController)

  plug(Guardian.Plug.EnsureAuthenticated)

  @spec index(any, map) :: {:error, :external_api, any} | Plug.Conn.t()
  def index(conn, %{"term" => term}) do
    case Core.search(term) do
      {:ok, games} ->
        render(conn, "index.json", games: games)

      {:error, reason} ->
        {:error, :external_api, reason}
    end
  end

  def index(conn, params) do
    case Core.top_games(params) do
      {:ok, games} ->
        render(conn, "index.json", games: games)

      {:error, reason} ->
        {:error, :external_api, reason}
    end
  end

  @spec show(any, map) :: {:error, :external_api, any} | Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    case Core.get(id) do
      {:ok, game} ->
        render(conn, "show.json", game: game)

      {:error, reason} ->
        {:error, :external_api, reason}
    end
  end
end
