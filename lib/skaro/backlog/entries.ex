defmodule Skaro.Backlog.Entries do
  @moduledoc """
  CRUD operations for backlog entries
  """
  import Ecto.Query
  import Skaro.Query

  alias Skaro.Repo
  alias Skaro.Backlog.{AvailablePlatform, Entry}

  def get_by_game_id!(user, game_id, preloads \\ [:available_platforms]) do
    Entry
    |> Repo.get_by!(%{user_id: user.id, game_id: game_id})
    |> Repo.preload(preloads)
  end

  def list(user, params, preloads \\ [:available_platforms]) do
    Entry
    |> filter_if_present(:user_id, user.id)
    |> filter_if_present(:status, params["status"])
    |> filter_if_present(:owned_platform_id, params["owned_platform_id"])
    |> filter_available_platforms(params["available_platform_id"])
    |> order_by_param(params["sort"])
    |> order_by_param("desc:game_release_date")
    |> preload_assoc(preloads)
    |> Repo.paginate(params)
  end

  def list_available_platforms(user, status) do
    Entry
    |> filter_if_present(:user_id, user.id)
    |> filter_if_present(:status, status)
    |> select_platforms
    |> Repo.all()
  end

  def list_owned_platforms(user, status) do
    Entry
    |> filter_if_present(:user_id, user.id)
    |> filter_if_present(:status, status)
    |> select_owned_platforms()
    |> Repo.all()
    |> map_to_platforms
  end

  def add(entry_params, user, platforms \\ []) do
    %Entry{}
    |> Entry.changeset(
      Map.merge(entry_params, %{
        "user_id" => user.id,
        "available_platforms" => platforms
      })
    )
    |> Repo.insert()
  end

  def update(entry, entry_params) do
    entry
    |> Entry.update(entry_params)
    |> Repo.update()
  end

  def delete(entry), do: Repo.delete!(entry)

  defp map_to_platforms(entries) do
    entries
    |> Enum.map(fn entry ->
      %AvailablePlatform{
        platform_id: entry.owned_platform_id,
        platform_name: entry.owned_platform_name
      }
    end)
    |> Enum.filter(& &1.platform_id)
  end

  defp select_platforms(query) do
    from(
      q in query,
      join: p in AvailablePlatform,
      on: q.id == p.entry_id,
      distinct: p.platform_id,
      select: p
    )
  end

  defp select_owned_platforms(query) do
    from(
      q in query,
      distinct: q.owned_platform_id,
      select: q
    )
  end

  defp filter_available_platforms(query, nil), do: query

  defp filter_available_platforms(query, available_platform_id) do
    from(
      q in query,
      join: p in AvailablePlatform,
      on: q.id == p.entry_id,
      where: p.platform_id == ^available_platform_id
    )
  end
end
