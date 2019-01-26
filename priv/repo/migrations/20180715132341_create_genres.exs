defmodule Skaro.Repo.Migrations.CreateGenres do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:genres) do
      add(:name, :string)
      add(:external_id, :string)
      add(:external_url, :string)

      timestamps()
    end

    create(unique_index(:genres, [:external_id]))
  end
end
