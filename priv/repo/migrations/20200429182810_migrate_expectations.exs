defmodule Skaro.Repo.Migrations.MigrateExpectations do
  use Ecto.Migration

  alias Skaro.Backlog.Entry
  alias Skaro.Repo

  def change do
    Entry
    |> Repo.all()
    |> Enum.each(fn entry ->
      {:ok, _} =
        entry
        |> Entry.update(%{expectation_rating: new_rating(entry.expectation_rating)})
        |> Repo.update()
    end)
  end

  defp new_rating(old) do
    case old do
      nil ->
        nil

      0 ->
        0

      5 ->
        3

      4 ->
        2

      _ ->
        1
    end
  end
end
