defmodule Skaro.Repo.Migrations.DropUniqueIndexPlaythroughTimes do
  use Ecto.Migration

  def change do
    drop_if_exists(index(:playthrough_times, [:external_id]))
  end
end
