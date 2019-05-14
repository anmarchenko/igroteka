defmodule SkaroWeb.SessionControllerTest do
  @moduledoc false
  use SkaroWeb.ConnCase

  import Skaro.Factory

  alias Skaro.Accounts.User
  alias Skaro.Guardian
  alias Skaro.Repo

  describe "POST :create" do
    test "returns jwt token when email and password are valid", %{conn: conn} do
      user = insert(:user)

      conn =
        post(
          conn,
          Routes.session_path(@endpoint, :create),
          session: %{email: user.email, password: "12345678"}
        )

      result = json_response(conn, 201)
      assert result
      assert result["user"]["id"] == user.id
      assert result["user"]["color"]
      assert result["user"]["initials"]

      saved_user = Repo.get!(User, user.id)

      # check jwt token validity
      {:ok, claims} = Guardian.decode_and_verify(result["jwt"])
      {:ok, ^saved_user} = Guardian.resource_from_claims(claims)
    end

    test "returns success when email and password are valid and email is written in caps",
         %{conn: conn} do
      user = insert(:user)

      conn =
        post(
          conn,
          Routes.session_path(@endpoint, :create),
          session: %{email: String.upcase(user.email), password: "12345678"}
        )

      assert json_response(conn, 201)
    end

    test "returns 422 error when password is invalid", %{conn: conn} do
      user = insert(:user)

      conn =
        post(
          conn,
          Routes.session_path(@endpoint, :create),
          session: %{email: user.email, password: "12345679"}
        )

      assert json_response(conn, 422)["errors"] != %{}
    end

    test "returns 422 error when email is missing", %{conn: conn} do
      conn =
        post(
          conn,
          Routes.session_path(@endpoint, :create),
          session: %{email: nil, password: "12345678"}
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
