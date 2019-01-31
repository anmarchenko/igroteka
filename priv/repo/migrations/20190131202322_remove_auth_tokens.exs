defmodule Skaro.Repo.Migrations.RemoveAuthTokens do
  use Ecto.Migration

  def change do
    drop table(:auth_tokens)
  end
end
