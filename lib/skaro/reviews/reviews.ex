defmodule Skaro.Reviews do
  @moduledoc """
  Fetching and saving critics reviews and ratings info
  """
  import Ecto.Query

  alias Skaro.Repo
  alias Skaro.Reviews.Rating
  alias Skaro.Tracing

  @event [:skaro, :reviews, :call]

  @spec find(%{id: integer(), name: binary(), release_date: Date.t()}) ::
          {:ok, Rating.t()} | {:error, any}
  def find(%{id: _, name: _} = game) do
    Tracer.with_span "reviews.find", kind: :client, attributes: %{game_name: game.name} do
      case Repo.get_by(Rating, game_id: game.id) do
        nil ->
          Tracer.set_attribute(:result, :cache_miss)

          load_rating(game)

        rating ->
          Tracer.set_attribute(:result, :cache_hit)

          {:ok, rating}
      end
    end
  end

  def by_games(game_ids) do
    query = from(r in Rating, where: r.game_id in ^game_ids)

    Repo.all(query)
  end

  def maybe_update(rating, game_release_date) do
    if needs_update?(rating, game_release_date) do
      Task.async(fn -> reload_rating(rating) end)
    end
  end

  def load_by_id(external_id, %{id: _, name: _} = game) do
    with {:ok, attrs} <- remote().get_by_id(external_id) do
      record_event(:load_by_id)

      create_rating(attrs, game)
    end
  end

  def needs_update?(rating, game_release_date) do
    today = Date.utc_today()

    update_interval = today |> Date.diff(game_release_date) |> get_update_interval()
    since_last_update = Date.diff(today, rating.updated_at)

    since_last_update >= update_interval
  end

  def reload_rating(rating) do
    with {:ok, attrs} <- remote().get_by_id(rating.external_id) do
      record_event(:reload_from_remote)

      update_rating(rating, attrs)
    end
  end

  defp load_rating(game) do
    with :ok <- check_release_date(game),
         {:ok, attrs} <- remote().find(game) do
      record_event(:load_from_remote)

      create_rating(attrs, game)
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

  defp check_release_date(%{release_date: release_date}) do
    two_weeks_from_now = Timex.shift(Timex.today(), days: 14)

    if Timex.before?(release_date, two_weeks_from_now) do
      :ok
    else
      record_event(:skipped_future_release)
      {:error, :future_release}
    end
  end

  defp record_event(result) do
    Tracing.send_count(@event, %{result: result})
  end
end
