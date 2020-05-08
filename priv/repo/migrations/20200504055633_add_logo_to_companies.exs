defmodule Skaro.Repo.Migrations.AddLogoToCompanies do
  use Ecto.Migration

  def change do
    alter table(:companies) do
      add(:logo_id, references(:images))
    end
  end
end
