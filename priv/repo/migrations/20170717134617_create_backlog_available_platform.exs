defmodule Skaro.Repo.Migrations.CreateSkaro.Backlog.AvailablePlatform do
  use Ecto.Migration

  def change do
    create table(:backlog_available_platforms) do
      add :platform_id, :integer
      add :platform_name, :string
      add :entry_id, references(:backlog_entries, on_delete: :delete_all)

      timestamps()
    end

    create index(:backlog_available_platforms, [:entry_id])
  end
end
