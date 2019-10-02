defmodule Skaro.Repo.Migrations.ReturnIndex do
  use Ecto.Migration

  def change do
    create unique_index(:backlog_entries, [:game_id, :user_id],
             name: :backlog_entries_unique_user_id_game_id_index
           )
  end
end
