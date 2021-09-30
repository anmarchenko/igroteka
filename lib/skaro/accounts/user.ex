defmodule Skaro.Accounts.User do
  @moduledoc """
    User entity
  """
  use Ecto.Schema

  import Ecto.Changeset

  alias Bcrypt

  schema "users" do
    field(:name, :string)
    field(:email, :string)
    field(:encrypted_password, :string)

    field(:password, :string, virtual: true)
    field(:old_password, :string, virtual: true)

    field(:stats, :map)

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :encrypted_password, :password])
    |> validate_required([:name, :email, :password])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> validate_confirmation(:password, message: "does not match confirmation")
    |> unique_constraint(:email, message: "has already been taken")
    |> generate_encrypted_password
  end

  def update_profile(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end

  def update_password(struct, params \\ %{}) do
    struct
    |> cast(params, [:old_password, :encrypted_password, :password])
    |> validate_current_password(struct.encrypted_password)
    |> validate_confirmation(:password, message: "does not match confirmation")
    |> generate_encrypted_password()
  end

  def update_stats(struct, params \\ %{}) do
    struct
    |> cast(params, [:stats])
  end

  defp generate_encrypted_password(current_changeset) do
    case current_changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(
          current_changeset,
          :encrypted_password,
          Bcrypt.hash_pwd_salt(password)
        )

      _ ->
        current_changeset
    end
  end

  defp validate_current_password(current_changeset, encrypted_password) do
    case current_changeset
         |> get_change(:old_password)
         |> Bcrypt.verify_pass(encrypted_password) do
      true -> current_changeset
      _ -> add_error(current_changeset, :old_password, "is invalid")
    end
  end
end
