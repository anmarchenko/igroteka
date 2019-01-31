defmodule Skaro.Repo.Migrations.RemoveBioNResetPasswordFromUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove(:bio)
      remove(:reset_password_jti)
    end
  end
end
