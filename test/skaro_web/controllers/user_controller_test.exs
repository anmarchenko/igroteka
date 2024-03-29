defmodule SkaroWeb.UserControllerTest do
  @moduledoc false
  use SkaroWeb.ConnCase

  import Skaro.Factory

  alias Bcrypt
  alias Skaro.Accounts.User
  alias Skaro.Repo

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  @valid_update_attrs %{name: "New user name"}
  @invalid_update_attrs %{name: ""}

  # GET :current
  @tag :login
  test "returns current user when authenticated", %{conn: conn, logged_user: user} do
    conn = get(conn, Routes.user_path(@endpoint, :current))
    user_json = json_response(conn, 200)
    assert user_json["id"] == user.id
    assert user_json["name"] == user.name
  end

  test "returns 403 error when not authenticated", %{conn: conn} do
    conn = get(conn, Routes.user_path(@endpoint, :current))
    assert response(conn, 401)
  end

  # GET :show
  @tag :login
  test "shows chosen resource", %{conn: conn} do
    user = insert(:user)
    conn = get(conn, Routes.user_path(@endpoint, :show, user))
    user_json = json_response(conn, 200)
    assert user_json["id"] == user.id
    assert user_json["name"] == user.name
    assert user_json["color"] == "user-color-#{rem(user.id, 4)}"
  end

  @tag :login
  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent(404, fn ->
      get(conn, Routes.user_path(@endpoint, :show, -1))
    end)
  end

  # PUT :update
  @tag :login
  test "allows logged user to edit her own name", %{conn: conn, logged_user: user} do
    conn = put(conn, Routes.user_path(@endpoint, :update, user), user: @valid_update_attrs)
    assert json_response(conn, 200)["id"]
    updated_user = Repo.get_by(User, @valid_update_attrs)
    assert updated_user
    assert updated_user.id == user.id
  end

  @tag :login
  test "does not allow to edit other users", %{conn: conn} do
    another_user = insert(:user)

    conn =
      put(conn, Routes.user_path(@endpoint, :update, another_user), user: @valid_update_attrs)

    updated_user = Repo.get!(User, another_user.id)
    assert updated_user.name == another_user.name

    assert json_response(conn, 403)
  end

  @tag :login
  test "returns errors if validations fail", %{conn: conn, logged_user: user} do
    conn = put(conn, Routes.user_path(@endpoint, :update, user), user: @invalid_update_attrs)

    assert json_response(conn, 422)["errors"] != %{}

    updated_user = Repo.get!(User, user.id)
    assert updated_user.name == user.name
  end

  # PUT :update_password
  @tag :login
  test "allows to change password if old password is supplied", %{
    conn: conn,
    logged_user: user
  } do
    conn =
      put(
        conn,
        "/api/users/#{user.id}/update_password",
        user: %{
          old_password: "12345678",
          password: "new_password",
          password_confirmation: "new_password"
        }
      )

    assert json_response(conn, 200)
    updated_user = Repo.get!(User, user.id)
    assert Bcrypt.verify_pass("new_password", updated_user.encrypted_password)
  end

  @tag :login
  test "returns error if old password is invalid", %{conn: conn, logged_user: user} do
    conn =
      put(
        conn,
        "/api/users/#{user.id}/update_password",
        user: %{
          old_password: "12345679",
          password: "new_password",
          password_confirmation: "new_password"
        }
      )

    json = json_response(conn, 422)
    assert json["errors"]["old_password"] == ["is invalid"]
    updated_user = Repo.get!(User, user.id)
    assert Bcrypt.verify_pass("12345678", updated_user.encrypted_password)
  end

  @tag :login
  test "returns error if confirmation does not match", %{conn: conn, logged_user: user} do
    conn =
      put(
        conn,
        "/api/users/#{user.id}/update_password",
        user: %{
          old_password: "12345678",
          password: "new_password",
          password_confirmation: "new_password2"
        }
      )

    json = json_response(conn, 422)
    assert json["errors"]["password_confirmation"] == ["does not match confirmation"]
    updated_user = Repo.get!(User, user.id)
    assert Bcrypt.verify_pass("12345678", updated_user.encrypted_password)
  end

  @tag :login
  test "does not allow to change details of another user", %{conn: conn} do
    another_user = insert(:user)

    conn =
      put(
        conn,
        "/api/users/#{another_user.id}/update_password",
        user: %{
          old_password: "12345678",
          password: "new_password",
          password_confirmation: "new_password"
        }
      )

    assert json_response(conn, 403)

    updated_user = Repo.get!(User, another_user.id)
    assert Bcrypt.verify_pass("12345678", updated_user.encrypted_password)
  end
end
