defmodule Skaro.Repo.Migrations.CreateGames do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:games) do
      add(:name, :string)
      add(:external_id, :string)
      add(:external_url, :string)

      add(:short_description, :text)
      add(:description, :text)
      add(:release_date, :date)

      add(:cover_id, references(:images))

      add(:rating, :float)
      add(:user_rating, :float)

      # main, DLC, expansion...
      add(:category, :integer)
      # release, alpha, beta...
      add(:status, :integer)

      add(:ttb_hastly, :integer)
      add(:ttb_normally, :integer)
      add(:ttb_completely, :integer)

      timestamps()
    end

    create table(:external_links) do
      add(:url, :string)
      add(:category_id, :string)
      add(:game_id, references(:games))

      timestamps()
    end

    create(unique_index(:games, [:external_id]))

    create table(:games_publishers) do
      add(:game_id, references(:games))
      add(:company_id, references(:companies))
    end

    create(unique_index(:games_publishers, [:game_id, :company_id]))

    create table(:games_developers) do
      add(:game_id, references(:games))
      add(:company_id, references(:companies))
    end

    create(unique_index(:games_developers, [:game_id, :company_id]))

    create table(:games_themes) do
      add(:game_id, references(:games))
      add(:theme_id, references(:themes))
    end

    create(unique_index(:games_themes, [:game_id, :theme_id]))

    create table(:games_genres) do
      add(:game_id, references(:games))
      add(:genre_id, references(:genres))
    end

    create(unique_index(:games_genres, [:game_id, :genre_id]))

    create table(:games_platforms) do
      add(:game_id, references(:games))
      add(:platform_id, references(:platforms))
    end

    create(unique_index(:games_platforms, [:game_id, :platform_id]))

    create table(:games_franchises) do
      add(:game_id, references(:games))
      add(:franchise_id, references(:franchises))
    end

    create(unique_index(:games_franchises, [:game_id, :franchise_id]))
  end
end
