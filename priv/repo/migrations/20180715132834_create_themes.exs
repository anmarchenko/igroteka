defmodule Skaro.Repo.Migrations.CreateThemes do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:themes) do
      add(:name, :string)
      add(:external_id, :string)
      add(:external_url, :string)

      timestamps()
    end

    create(unique_index(:themes, [:external_id]))
  end
end
