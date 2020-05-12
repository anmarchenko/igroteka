defmodule Skaro.Repo.Migrations.UpdateBacklogEntriesAgain do
  @moduledoc false
  use Ecto.Migration

  alias Skaro.Backlog.Entry
  alias Skaro.Repo

  alias Skaro.IGDB

  def up do
    Application.ensure_all_started(:hackney)

    Entry
    |> Repo.all()
    |> Enum.each(fn entry ->
      if (entry.countries || []) |> Enum.filter(& &1) |> Enum.empty?() do
        {:ok, game} = IGDB.find_one(entry.game_id)

        {:ok, _} =
          entry
          |> Entry.migrate(%{countries: countries(game)})
          |> Repo.update()
      end
    end)
  end

  def down do
  end

  defp countries(game) do
    game.developers |> Enum.map(& &1.country) |> Enum.filter(& &1)
  end
end
