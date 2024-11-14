defmodule Skaro.Core do
  @moduledoc """
  Set of functions to access games resources.
  All functions are implemented in backend.
  """

  alias Skaro.Backlog.Entries
  alias Skaro.Playthrough
  alias Skaro.Reviews

  require OpenTelemetry.Tracer, as: Tracer

  def get(id) do
    Tracer.with_span "core.get",
      kind: :client,
      attributes: %{game_id: id} do
      cached_result("games_show_#{id}_v1.0", fn ->
        Tracer.set_attribute(:cache_miss, true)

        games_remote().find_one(id)
      end)
    end
  end

  def get_company(id) do
    Tracer.with_span "core.get_company",
      kind: :client,
      attributes: %{company_id: id} do
      cached_result("companies_show_#{id}_v1.0", fn ->
        Tracer.set_attribute(:cache_miss, true)

        games_remote().fetch_company(id)
      end)
    end
  end

  def search(term, user_id) do
    Tracer.with_span "core.search", kind: :client do
      res =
        cached_result("games_index_term_#{term}_v1.0", fn ->
          Tracer.set_attribute(:cache_miss, true)

          games_remote().search(term)
        end)

      preload_games_associations(res, user_id)
    end
  end

  def get_screenshots(game_id) do
    Tracer.with_span "core.get_screenshots", kind: :client, attributes: %{game_id: game_id} do
      cached_result("screenshots_index_game_#{game_id}", fn ->
        Tracer.set_attribute(:cache_miss, true)

        games_remote().get_screenshots(game_id)
      end)
    end
  end

  def top_games(filters, user_id) do
    Tracer.with_span "core.top_games", kind: :client do
      res =
        cached_result(
          "games_index_top_year_#{filters["year"]}_platform_#{filters["platform"]}",
          fn ->
            Tracer.set_attribute(:cache_miss, true)

            games_remote().top_games(filters)
          end
        )

      preload_games_associations(res, user_id)
    end
  end

  def fetch_games(filters, user_id) do
    Tracer.with_span "core.fetch_games", kind: :client do
      res =
        cached_result(
          "games_index_developer_#{filters["developer"]}_publisher_#{filters["publisher"]}_offset_#{filters["offset"]}",
          fn ->
            Tracer.set_attribute(:cache_miss, true)

            games_remote().fetch_games(filters)
          end
        )

      preload_games_associations(res, user_id)
    end
  end

  def new_games(user_id) do
    Tracer.with_span "core.new_games", kind: :client do
      res =
        cached_result("games_index_new", fn ->
          Tracer.set_attribute(:cache_miss, true)

          games_remote().new_games()
        end)

      preload_games_associations(res, user_id)
    end
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

    times_map = ids |> Playthrough.by_games() |> Enum.into(%{}, fn p -> {p.game_id, p} end)
    reviews_map = ids |> Reviews.by_games() |> Enum.into(%{}, fn r -> {r.game_id, r} end)

    {:ok,
     games
     |> Enum.map(fn game -> game |> with_entry(entries_map) end)
     |> Enum.map(fn game -> game |> with_playthrough_time(times_map) end)
     |> Enum.map(fn game -> game |> with_reviews(reviews_map) end)}
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

  defp with_playthrough_time(game, times_map) do
    if times_map[game.id] do
      %{game | playthrough_time: times_map[game.id]}
    else
      %{game | playthrough_time: nil}
    end
  end

  defp with_reviews(game, reviews_map) do
    if reviews_map[game.id] do
      %{game | critics_rating: reviews_map[game.id]}
    else
      %{game | critics_rating: nil}
    end
  end
end
