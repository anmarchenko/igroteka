defmodule SkaroWeb.GameController do
  use SkaroWeb, :controller

  alias Skaro.Core

  action_fallback(SkaroWeb.FallbackController)

  plug(Guardian.Plug.EnsureAuthenticated)

  @spec index(any, map) :: {:error, :external_api, any} | Plug.Conn.t()
  def index(conn, %{"term" => term}) do
    term
    |> Core.search()
    |> respond(conn)
  end

  def index(conn, %{"new" => _}) do
    respond(Core.new_games(), conn)
  end

  def index(conn, params) do
    params
    |> Core.top_games()
    |> respond(conn)
  end

  @spec show(any, map) :: {:error, :external_api, any} | Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    id
    |> Core.get()
    |> respond(conn)
  end

  defp respond({:ok, games}, conn) when is_list(games) do
    render(conn, "index.json", games: games)
  end

  defp respond({:ok, game}, conn) do
    render(conn, "show.json", game: game)
  end

  defp respond({:error, reason}, _) do
    {:error, :external_api, reason}
  end
end
