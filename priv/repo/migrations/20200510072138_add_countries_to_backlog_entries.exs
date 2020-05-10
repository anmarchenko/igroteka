defmodule Skaro.Repo.Migrations.AddCountriesToBacklogEntries do
  @moduledoc false
  use Ecto.Migration

  def change do
    alter table(:backlog_entries) do
      add(:countries, {:array, :string})
    end
  end
end
