defmodule Skaro.Core do
  @moduledoc """
  Set of functions to access games resources.
  All functions are implemented in backend.
  """

  alias Skaro.Backlog.Entries

  def get(id) do
    cached_result("games_show_#{id}_v1.0", fn ->
      games_remote().find_one(id)
    end)
  end

  def search(term, user_id) do
    cached_result("games_index_term_#{term}_v1.0", fn ->
      games_remote().search(term)
    end)
    |> preload_games_associations(user_id)
  end

  def get_screenshots(game_id) do
    cached_result("screenshots_index_game_#{game_id}", fn ->
      games_remote().get_screenshots(game_id)
    end)
  end

  def top_games(filters, user_id) do
    cached_result("games_index_top_year_#{filters["year"]}_platform_#{filters["platform"]}", fn ->
      games_remote().top_games(filters)
    end)
    |> preload_games_associations(user_id)
  end

  def new_games(user_id) do
    cached_result("games_index_new", fn ->
      games_remote().new_games()
    end)
    |> preload_games_associations(user_id)
  end

  defp cached_result(cache_key, api_call) do
    case ConCache.get(:external_api_cache, cache_key) do
      nil ->
        case api_call.() do
          {:ok, result} ->
            ConCache.put(:external_api_cache, cache_key, result)
            {:ok, result}

          {:error, reason} ->
            {:error, reason}
        end

      result ->
        {:ok, result}
    end
  end

  defp preload_games_associations({:ok, games}, user_id) do
    ids = Enum.map(games, & &1.id)

    entries_map =
      ids
      |> Entries.by_games(user_id)
      |> Enum.into(%{}, fn entry -> {entry.game_id, entry} end)

    {:ok, games |> Enum.map(fn game -> game |> with_entry(entries_map) end)}
  end

  defp preload_games_associations(error, _), do: error

  defp games_remote, do: Application.get_env(:skaro, :games_remote)

  defp with_entry(game, entries_map) do
    if entries_map[game.id] do
      %{game | backlog_entries: [entries_map[game.id]]}
    else
      %{game | backlog_entries: []}
    end
  end
end
