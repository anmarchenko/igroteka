defmodule Skaro.Repo.Migrations.CreateCompanies do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:companies) do
      add(:name, :string)
      add(:external_id, :string)
      add(:external_url, :string)
      add(:website, :string)

      add(:description, :text)
      add(:twitter, :string)
      add(:country, :string)
      add(:start_date, :date)

      timestamps()
    end

    create(unique_index(:companies, [:external_id]))
  end
end
