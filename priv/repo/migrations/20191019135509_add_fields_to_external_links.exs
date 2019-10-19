defmodule Skaro.Repo.Migrations.AddFieldsToExternalLinks do
  use Ecto.Migration

  def change do
    alter table(:external_links) do
      add(:external_id, :string)
      add(:external_category_id, :string)
    end

    rename table(:external_links), :category_id, to: :category
  end
end
