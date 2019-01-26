defmodule Skaro.Repo.Migrations.AddPlatforms do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:platforms) do
      add(:name, :string)
      add(:alternative_name, :string)
      add(:generation, :integer)
      add(:summary, :text)
      add(:website, :string)

      add(:external_id, :string)
      add(:external_url, :string)

      timestamps()
    end

    create(unique_index(:platforms, [:external_id]))
  end
end
