defmodule Skaro.Playthrough do
  @moduledoc """
  Playthrough times for games (how long it takes to finish)
  """
  alias Skaro.Playthrough.PlaythroughTime
  alias Skaro.Repo

  @remote Application.get_env(:skaro, :playthrough_remote)

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

  def maybe_update(playthrough_time, game_release_date) do
    if needs_update?(playthrough_time, game_release_date) do
      Task.async(fn -> reload_playthrough_time(playthrough_time) end)
    end
  end

  def needs_update?(time, game_release_date) do
    today = Date.utc_today()

    update_interval = today |> Date.diff(game_release_date) |> get_update_interval()
    since_last_update = Date.diff(today, time.updated_at)

    since_last_update >= update_interval
  end

  def reload_playthrough_time(time) do
    with {:ok, attrs} <- @remote.get_by_id(time.game_id),
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
    with {:ok, attrs} <- @remote.find(game),
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

  # released last week - update every day
  defp get_update_interval(days_since_release) when days_since_release < 8, do: 1
  # released last month - update every week
  defp get_update_interval(days_since_release) when days_since_release < 30, do: 7
  # released last 3 months - update every month
  defp get_update_interval(days_since_release) when days_since_release < 90, do: 30
  # otherwise update every 6 months
  defp get_update_interval(_), do: 180
end
