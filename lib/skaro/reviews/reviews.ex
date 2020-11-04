defmodule Skaro.Reviews do
  @moduledoc """
  Fetching and saving critics reviews and ratings info
  """

  alias Skaro.Repo
  alias Skaro.Reviews.Rating

  @spec find(%{id: integer(), name: binary(), release_date: Date.t()}) ::
          {:ok, Rating.t()} | {:error, any}
  def find(%{id: _, name: _, release_date: _} = game) do
    case Repo.get_by(Rating, game_id: game.id) do
      nil ->
        load_rating(game)

      rating ->
        {:ok, rating}
    end
  end

  def maybe_update(rating, game_release_date) do
    if needs_update?(rating, game_release_date) do
      Task.async(fn -> reload_rating(rating) end)
    end
  end

  def load_by_id(external_id, %{id: _, name: _} = game) do
    with {:ok, attrs} <- remote().get_by_id(external_id),
         {:ok, rating} <- create_rating(attrs, game) do
      {:ok, rating}
    end
  end

  def needs_update?(rating, game_release_date) do
    today = Date.utc_today()

    update_interval = today |> Date.diff(game_release_date) |> get_update_interval()
    since_last_update = Date.diff(today, rating.updated_at)

    since_last_update >= update_interval
  end

  def reload_rating(rating) do
    with {:ok, attrs} <- remote().get_by_id(rating.external_id),
         {:ok, updated} <- update_rating(rating, attrs) do
      {:ok, updated}
    end
  end

  defp load_rating(game) do
    with {:ok, attrs} <- remote().find(game),
         {:ok, rating} <- create_rating(attrs, game) do
      {:ok, rating}
    end
  end

  defp create_rating(attrs, game) do
    %Rating{game_id: game.id, game_name: game.name}
    |> Rating.changeset(attrs)
    |> Repo.insert()
  end

  defp update_rating(rating, attrs) do
    rating
    |> Rating.changeset_update(attrs)
    |> Repo.update()
  end

  # released in the last 3 months - update every day
  defp get_update_interval(days_since_release) when days_since_release < 90, do: 1
  # otherwise update every week
  defp get_update_interval(_), do: 7

  defp remote, do: Application.get_env(:skaro, :reviews_remote)
end
