defmodule Skaro.UserTest do
  use Skaro.DataCase

  import Skaro.Factory

  alias Skaro.Accounts.User

  @valid_attrs %{
    email: "test@mail.test",
    password: "password",
    password_confirmation: "password",
    name: "some content"
  }
  @empty_attrs %{}
  @invalid_email_attrs %{
    email: "test",
    password: "password",
    password_confirmation: "password",
    name: "some content"
  }

  @no_email_attrs %{
    password: "password",
    password_confirmation: "password",
    name: "some content"
  }

  @short_password_attrs %{
    email: "test@email.test",
    password: "123",
    password_confirmation: "123",
    name: "some content"
  }

  @wrong_confirmation_attrs %{
    email: "test@email.test",
    password: "password",
    password_confirmation: "wrong password",
    name: "some content"
  }

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with empty attributes" do
    changeset = User.changeset(%User{}, @empty_attrs)
    refute changeset.valid?
  end

  test "changeset with no email attributes" do
    changeset = User.changeset(%User{}, @no_email_attrs)
    refute changeset.valid?
    assert {:email, {"can't be blank", [validation: :required]}} in changeset.errors
  end

  test "changeset with invalid email attributes" do
    changeset = User.changeset(%User{}, @invalid_email_attrs)
    refute changeset.valid?
    assert {:email, {"has invalid format", [validation: :format]}} in changeset.errors
  end

  test "changeset with short password attributes" do
    changeset = User.changeset(%User{}, @short_password_attrs)
    refute changeset.valid?
  end

  test "changeset with wrong confirmation attributes" do
    changeset = User.changeset(%User{}, @wrong_confirmation_attrs)
    refute changeset.valid?
  end

  test "insert user" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert {:ok, user} = Repo.insert(changeset)
    assert Bcrypt.verify_pass("password", user.encrypted_password)
  end

  test "changeset with duplicate email" do
    existing_user = insert(:user)

    changeset =
      User.changeset(
        %User{email: existing_user.email},
        @no_email_attrs
      )

    assert {:error, _} = Repo.insert(changeset)
  end
end
