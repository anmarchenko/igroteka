defmodule Skaro.Repo.Migrations.CreateImages do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:images) do
      add(:big_url, :string)
      add(:thumb_url, :string)

      timestamps()
    end
  end
end
