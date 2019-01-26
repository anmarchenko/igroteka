defmodule Skaro.Repo.Migrations.AddExpectationRatingToBacklogEntries do
  @moduledoc false
  use Ecto.Migration

  def change do
    alter table(:backlog_entries) do
      add(:expectation_rating, :integer)
    end
  end
end
