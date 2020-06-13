defmodule Skaro.Playthrough do
  @moduledoc """
  Playthrough times for games (how long it takes to finish)
  """
  alias Skaro.Core.Game
  alias Skaro.Playthrough.PlaythroughTime
  alias Skaro.Repo

  @remote Application.get_env(:skaro, :playthrough_remote)

  def find(%Game{} = game) do
    case Repo.get_by(PlaythroughTime, game_id: game.id) do
      nil ->
        load_playthrough_time(game)

      time ->
        {:ok, time}
    end
  end

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
