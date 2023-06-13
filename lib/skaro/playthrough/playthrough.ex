defmodule Skaro.Playthrough do
  @moduledoc """
  Playthrough times for games (how long it takes to finish)
  """
  import Ecto.Query

  alias Skaro.Playthrough.PlaythroughTime
  alias Skaro.Repo

  @spec find(%{id: integer(), name: binary(), release_date: Date.t()}) ::
          {:ok, PlaythroughTime.t()} | {:error, any}
  def find(%{id: _, name: _, release_date: _} = game) do
    case Repo.get_by(PlaythroughTime, game_id: game.id) do
      nil ->
        load_playthrough_time(game)

      time ->
        {:ok, time}
    end
  end

  def by_games(game_ids) do
    from(p in PlaythroughTime, where: p.game_id in ^game_ids)
    |> Repo.all()
  end

  def maybe_update(playthrough_time, game_release_date) do
    if needs_update?(playthrough_time, game_release_date) do
      Task.async(fn -> reload_playthrough_time(playthrough_time) end)
    end
  end

  def load_by_id(external_id, %{id: _, name: _} = game) do
    with {:ok, attrs} <- remote().get_by_id(external_id),
         {:ok, time} <- create_playthrough_time(attrs, game) do
      {:ok, time}
    end
  end

  def needs_update?(time, game_release_date) do
    today = Date.utc_today()

    update_interval = today |> Date.diff(game_release_date) |> get_update_interval()
    since_last_update = Date.diff(today, time.updated_at)

    since_last_update >= update_interval
  end

  def reload_playthrough_time(time) do
    with {:ok, attrs} <- remote().get_by_id(time.external_id),
         {:ok, updated} <- update_playthrough_time(time, attrs) do
      {:ok, updated}
    end
  end

  # <= 6 hours
  def category_badge(%{main: main}) when main <= 360,
    do: %{badge: "very-short", badge_label: "Very short"}

  # <= 12 hours
  def category_badge(%{main: main}) when is_integer(main) and main <= 720,
    do: %{badge: "short", badge_label: "Short"}

  # <= 18 hours
  def category_badge(%{main: main}) when is_integer(main) and main <= 1080,
    do: %{badge: "fair", badge_label: "Fair length"}

  # <= 36 hours
  def category_badge(%{main: main}) when is_integer(main) and main <= 2160,
    do: %{badge: "average", badge_label: "Average length"}

  # <= 72 hours
  def category_badge(%{main: main}) when is_integer(main) and main <= 4320,
    do: %{badge: "long", badge_label: "Long"}

  # > 72 hours
  def category_badge(%{main: main}) when is_integer(main) and main > 4320,
    do: %{badge: "very-long", badge_label: "Very long"}

  def category_badge(_),
    do: %{}

  defp load_playthrough_time(game) do
    with :ok <- check_release_date(game),
         {:ok, attrs} <- remote().find(game),
         {:ok, time} <- create_playthrough_time(attrs, game) do
      {:ok, time}
    end
  end

  defp create_playthrough_time(attrs, game) do
    %PlaythroughTime{game_id: game.id, game_name: game.name}
    |> PlaythroughTime.changeset(attrs)
    |> Repo.insert()
  end

  defp update_playthrough_time(time, attrs) do
    time
    |> PlaythroughTime.changeset_update(attrs)
    |> Repo.update()
  end

  # released in the last 3 months - update every day
  defp get_update_interval(days_since_release) when days_since_release < 90, do: 1
  # otherwise update every week
  defp get_update_interval(_), do: 7

  defp remote, do: Application.get_env(:skaro, :playthrough_remote)

  defp check_release_date(%{release_date: release_date}) do
    tomorrow = Timex.shift(Timex.today(), days: 1)

    if Timex.before?(release_date, tomorrow) do
      :ok
    else
      {:error, :future_release}
    end
  end
end
