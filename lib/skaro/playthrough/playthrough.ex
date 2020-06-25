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
end
