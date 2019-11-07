defmodule Skaro.Repo.Migrations.MigrateScores do
  use Ecto.Migration

  alias Skaro.Backlog.Entry
  alias Skaro.Repo

  def change do
    Entry
    |> Repo.all()
    |> Enum.each(fn entry ->
      {:ok, _} =
        entry
        |> Entry.update(%{score: new_score(entry.score)})
        |> Repo.update()
    end)
  end

  defp new_score(old_score) do
    case old_score do
      nil ->
        nil

      0 ->
        0

      10 ->
        5

      9 ->
        4

      8 ->
        3

      x when x > 5 and x < 8 ->
        2

      _ ->
        1
    end
  end
end
