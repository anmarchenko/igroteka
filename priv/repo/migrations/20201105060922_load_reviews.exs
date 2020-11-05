defmodule Skaro.Repo.Migrations.LoadReviews do
  use Ecto.Migration

  alias Skaro.Backlog.Entry
  alias Skaro.Core.Game
  alias Skaro.Repo

  alias Skaro.Reviews

  def change do
    Application.ensure_all_started(:hackney)

    Entry
    |> Repo.all()
    |> Enum.with_index()
    |> Enum.each(fn {entry, index} ->
      if rem(index, 10) == 0, do: :timer.sleep(3000)
      IO.puts("Loading reviews for #{entry.id} (#{entry.game_name})...")

      result =
        Reviews.find(%Game{
          id: entry.game_id,
          name: entry.game_name
        })

      IO.puts("Result was [#{inspect(result)}]")
    end)

  end
end
