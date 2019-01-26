defmodule Skaro.Repo.Migrations.RemoveLocaleFromUsers do
  @moduledoc false
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove(:locale)
    end
  end
end
