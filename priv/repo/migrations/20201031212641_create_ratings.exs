defmodule Skaro.Repo.Migrations.CreateRatings do
  use Ecto.Migration

  def change do
    create table(:ratings) do
      add(:external_id, :string)

      add(:percent_recommended, :float)
      add(:score, :float)
      add(:num_reviews, :integer)

      add(:tier, :string)
      add(:summary, :text)
      add(:reviews, {:array, :map})
      add(:points, {:array, :map})

      add(:game_id, :integer)
      add(:game_name, :string)

      timestamps()
    end

    create(index(:ratings, [:external_id]))
    create(index(:ratings, [:game_id]))
  end
end
