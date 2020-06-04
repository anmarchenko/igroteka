defmodule Skaro.Repo.Migrations.CreatePlaythroughTimes do
  use Ecto.Migration

  def change do
    create table(:playthrough_times) do
      add(:external_id, :string)
      add(:external_url, :string)

      add(:main, :integer)
      add(:main_extra, :integer)
      add(:completionist, :integer)

      add(:game_id, :integer)
      add(:game_name, :string)

      timestamps()
    end

    create(unique_index(:playthrough_times, [:external_id]))
  end
end
