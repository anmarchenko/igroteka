defmodule Skaro.Backlog.Entries do
  @moduledoc """
  CRUD operations for backlog entries
  """
  import Ecto.Query
  import Skaro.Query

  alias Skaro.Repo
  alias Skaro.Backlog.{AvailablePlatform, Entry}

  @spec get_by_game_id!(atom | %{id: any}, any, atom | [any]) ::
          nil | [%{optional(atom) => any}] | %{optional(atom) => any}
  def get_by_game_id!(user, game_id, preloads \\ [:available_platforms]) do
    Entry
    |> Repo.get_by!(%{user_id: user.id, game_id: game_id})
    |> Repo.preload(preloads)
  end

  @spec list(atom | %{id: any}, keyword | map, any) :: Scrivener.Page.t()
  def list(user, params, preloads \\ [:available_platforms, :playthrough_time, :rating]) do
    Entry
    |> filter_if_present(:user_id, user.id)
    |> filter_if_present(:status, params["status"])
    |> filter_if_present(:owned_platform_id, params["owned_platform_id"])
    |> filter_by_year(:game_release_date, params["release_year"])
    |> preload_assoc(preloads)
    |> order_by_param(params["sort"])
    |> order_by_param("desc:game_release_date")
    |> Repo.paginate(params)
  end

  def list_platforms_filter(user, status) do
    Entry
    |> filter_if_present(:user_id, user.id)
    |> filter_if_present(:status, status)
    |> select_owned_platforms()
    |> Repo.all()
    |> map_to_platforms()
  end

  def list_years_filter(user, status) do
    Entry
    |> filter_if_present(:user_id, user.id)
    |> filter_if_present(:status, status)
    |> select_release_dates()
    |> Repo.all()
    |> Enum.filter(&(&1 != nil))
    |> map_to_years()
    |> Enum.sort(:desc)
    |> Enum.uniq()
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

  def update_entries_for_game(%{
        id: game_id,
        name: game_name,
        release_date: game_release_data,
        developers: developers,
        cover: %{thumb_url: poster_thumb_url}
      }) do
    {:ok, now} = DateTime.now("Etc/UTC")
    yesterday = Timex.shift(now, days: -1)

    query = from(e in Entry, where: e.game_id == ^game_id and e.updated_at < ^yesterday)

    Repo.update_all(query,
      set: [
        game_name: game_name,
        poster_thumb_url: poster_thumb_url,
        game_release_date: game_release_data,
        countries: countries(developers),
        updated_at: now
      ]
    )
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

  defp map_to_years(release_dates) do
    release_dates
    |> Enum.map(fn date ->
      date.year
    end)
  end

  defp select_owned_platforms(query) do
    from(
      q in query,
      distinct: q.owned_platform_id,
      select: q
    )
  end

  defp select_release_dates(query) do
    from(
      q in query,
      distinct: q.game_release_date,
      select: q.game_release_date
    )
  end

  defp filter_by_year(query, _, nil), do: query

  defp filter_by_year(query, param, year) when is_binary(year) do
    {year, _} = Integer.parse(year)
    filter_by_year(query, param, year)
  end

  defp filter_by_year(query, param, year) when is_integer(year) do
    {:ok, start_date} = Date.new(year, 1, 1)
    {:ok, end_date} = Date.new(year, 12, 31)
    from(p in query, where: field(p, ^param) >= ^start_date and field(p, ^param) <= ^end_date)
  end

  defp countries(nil), do: []
  defp countries([]), do: []

  defp countries(companies) do
    companies
    |> Enum.map(& &1.country)
    |> Enum.uniq()
  end
end
