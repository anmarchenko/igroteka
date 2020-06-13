defmodule Skaro.Repo.Migrations.CreateIndexPlaythroughTimesGameId do
  use Ecto.Migration

  def change do
    create(unique_index(:playthrough_times, [:game_id]))
  end
end
