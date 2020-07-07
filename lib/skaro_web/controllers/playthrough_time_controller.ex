defmodule SkaroWeb.PlaythroughTimeController do
  use SkaroWeb, :controller

  alias Skaro.Playthrough

  action_fallback(SkaroWeb.FallbackController)

  plug(Guardian.Plug.EnsureAuthenticated)

  def show(conn, %{"id" => game_id, "name" => game_name, "release_date" => game_release_date}) do
    with {:ok, date_parsed} <- Date.from_iso8601(game_release_date),
         {game_id_parsed, _} <- Integer.parse(game_id),
         {:ok, time} <-
           Playthrough.find(%{id: game_id_parsed, name: game_name, release_date: date_parsed}) do
      Playthrough.maybe_update(time, date_parsed)

      render(conn, "show.json", playthrough_time: time)
    else
      {:error, :invalid_format} ->
        {:error, :bad_request}

      {:error, :invalid_date} ->
        {:error, :bad_request}

      :error ->
        {:error, :bad_request}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, changeset}

      {:error, reason} ->
        {:error, :external_api, reason}
    end
  end

  def show(_, _), do: {:error, :bad_request}
end
