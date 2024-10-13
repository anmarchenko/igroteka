defmodule SkaroWeb.ReviewController do
  use SkaroWeb, :controller

  alias Skaro.Reviews

  action_fallback(SkaroWeb.FallbackController)

  plug(Guardian.Plug.EnsureAuthenticated)

  def show(conn, %{"id" => game_id, "name" => game_name, "release_date" => game_release_date}) do
    with {:ok, date_parsed} <- Date.from_iso8601(game_release_date),
         {game_id_parsed, _} <- Integer.parse(game_id),
         {:ok, rating} <-
           Reviews.find(%{id: game_id_parsed, name: game_name, release_date: date_parsed}) do
      Reviews.maybe_update(rating, date_parsed)

      Tracer.set_attribute(:result, :ok)
      Tracer.set_status(OpenTelemetry.status(:ok, ""))

      render(conn, "show.json", rating: rating)
    else
      {:error, :invalid_format} ->
        Tracer.set_attribute(:result, :invalid_format)
        {:error, :bad_request}

      {:error, :invalid_date} ->
        Tracer.set_attribute(:result, :invalid_date)
        {:error, :bad_request}

      {:error, :future_release} ->
        Tracer.set_attribute(:result, :future_release)
        {:error, :bad_request}

      {:error, :not_found} ->
        Tracer.set_attribute(:result, :game_not_found)
        {:error, :not_found}

      :error ->
        Tracer.set_attribute(:result, :game_id_parse_failure)
        {:error, :bad_request}

      {:error, %Ecto.Changeset{} = changeset} ->
        Tracer.set_attribute(:result, :db_insert_failure)
        Tracer.set_status(OpenTelemetry.status(:error, inspect(changeset.errors)))

        {:error, changeset}

      {:error, reason} ->
        Tracer.set_attribute(:result, :external_api_failure)
        Tracer.set_status(OpenTelemetry.status(:error, "Opencrtic API failure: #{reason}"))

        {:error, :external_api, reason}
    end
  end

  def show(_, _), do: {:error, :bad_request}
end
