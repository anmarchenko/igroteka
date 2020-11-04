defmodule Skaro.Core do
  @moduledoc """
  Set of functions to access games resources.
  All functions are implemented in backend.
  """

  def get(id) do
    cached_result("games_show_#{id}_v1.0", fn ->
      games_remote().find_one(id)
    end)
  end

  def search(term) do
    cached_result("games_index_term_#{term}_v1.0", fn ->
      games_remote().search(term)
    end)
  end

  def get_screenshots(game_id) do
    cached_result("screenshots_index_game_#{game_id}", fn ->
      games_remote().get_screenshots(game_id)
    end)
  end

  def top_games(filters) do
    cached_result("games_index_top_year_#{filters["year"]}_platform_#{filters["platform"]}", fn ->
      games_remote().top_games(filters)
    end)
  end

  def new_games do
    cached_result("games_index_new", fn ->
      games_remote().new_games()
    end)
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

  defp games_remote, do: Application.get_env(:skaro, :games_remote)
end
