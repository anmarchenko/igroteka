defmodule Skaro.Repo.Migrations.CreateFranchises do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:franchises) do
      add(:name, :string)
      add(:external_id, :string)
      add(:external_url, :string)

      timestamps()
    end

    create(unique_index(:franchises, [:external_id]))
  end
end
