defmodule Skaro.Repo.Migrations.DropUniqueIndex do
  use Ecto.Migration

  def change do
    drop unique_index(:backlog_entries, [:game_id, :user_id],
           name: :backlog_entries_unique_user_id_game_id_index
         )
  end
end
