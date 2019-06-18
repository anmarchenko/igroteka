defmodule Skaro.Repo.Migrations.AddRatingsCountToGames do
  use Ecto.Migration

  def change do
    alter table(:games) do
      add(:ratings_count, :integer)
      remove(:user_rating)
    end
  end
end
