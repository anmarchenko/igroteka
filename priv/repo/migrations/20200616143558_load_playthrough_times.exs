defmodule Skaro.Repo.Migrations.LoadPlaythroughTimes do
  use Ecto.Migration

  alias Skaro.Backlog.Entry
  alias Skaro.Core.Game
  alias Skaro.Repo

  alias Skaro.Playthrough

  def up do
    Application.ensure_all_started(:hackney)

    Entry
    |> Repo.all()
    |> Enum.with_index()
    |> Enum.each(fn {entry, index} ->
      if rem(index, 10) == 0, do: :timer.sleep(3000)
      IO.puts("Loading time for #{entry.id} (#{entry.game_name})...")

      result =
        Playthrough.find(%Game{
          id: entry.game_id,
          name: entry.game_name,
          release_date: entry.game_release_date
        })

      IO.puts("Result was [#{inspect(result)}]")
    end)
  end

  def down do
  end
end
