defmodule Skaro.Repo.Migrations.UpdateBacklogEntries do
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
      {:ok, game} = IGDB.find_one(entry.game_id)

      {:ok, _} =
        entry
        |> Entry.migrate(%{countries: countries(game)})
        |> Repo.update()
    end)
  end

  def down do
  end

  defp countries(game) do
    Enum.map(game.developers, & &1.country)
  end
end
