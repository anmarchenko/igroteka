defmodule Skaro.Repo.Migrations.CreateSkaro.Backlog.Entry do
  use Ecto.Migration

  def change do
    create table(:backlog_entries) do
      add :game_id, :integer
      add :game_name, :string
      add :game_release_date, :date
      add :owned_platform_id, :integer
      add :owned_platform_name, :string
      add :finished_at, :date
      add :score, :integer
      add :status, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :note, :string
      add :poster_thumb_url, :string

      timestamps()
    end

    create index(:backlog_entries, [:user_id])
    create unique_index(:backlog_entries, [:game_id, :user_id],
                        name: :backlog_entries_unique_user_id_game_id_index)
  end
end
