defmodule Skaro.Core do
  @moduledoc """
  Set of functions to access games resources.
  All functions are implemented in backend.
  """

  @remote Application.get_env(:skaro, :games_remote)

  def get(id) do
    cached_result("game_show_#{id}_v0.1", fn ->
      @remote.find_one(id)
    end)
  end

  def search(term) do
    @remote.search(term)
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
