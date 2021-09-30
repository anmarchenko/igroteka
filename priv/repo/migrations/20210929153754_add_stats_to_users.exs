defmodule Skaro.Repo.Migrations.AddStatsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add(:stats, :map)
    end
  end
end
