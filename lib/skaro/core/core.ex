defmodule Skaro.Core do
  @moduledoc """
  Set of functions to access games resources.
  All functions are implemented in backend.
  """

  @remote Application.get_env(:skaro, :games_remote)

  def get(id) do
    cached_result("games_show_#{id}_v1.0", fn ->
      @remote.find_one(id)
    end)
  end

  def search(term) do
    cached_result("games_index_term_#{term}_v1.0", fn ->
      @remote.search(term)
    end)
  end

  def get_screenshots(game_id) do
    cached_result("screenshots_index_game_#{game_id}", fn ->
      @remote.get_screenshots(game_id)
    end)
  end

  def top_games(filters) do
    cached_result("games_index_top_year_#{filters["year"]}_platform_#{filters["platform"]}", fn ->
      @remote.top_games(filters)
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
end
