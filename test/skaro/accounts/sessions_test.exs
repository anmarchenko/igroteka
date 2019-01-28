defmodule Skaro.SessionsTest do
  use Skaro.DataCase

  import Skaro.Factory

  alias Skaro.Accounts.Sessions
  alias Skaro.Guardian

  describe "Sessions.authenticate/1" do
    test "it returns failed auth when given email is nil" do
      assert {:error, :auth_failed} =
               Sessions.authenticate(%{"email" => nil, "password" => "1232"})
    end

    test "it returns failed auth when given email is empty" do
      assert {:error, :auth_failed} =
               Sessions.authenticate(%{"email" => "", "password" => "1232"})
    end

    test "it returns failed auth when there is no user with given email" do
      insert(:user)

      assert {:error, :auth_failed} =
               Sessions.authenticate(%{
                 "email" => "some@email.com",
                 "password" => "12345678"
               })
    end

    test "it returns failed auth when password is incorrect" do
      user = insert(:user)

      assert {:error, :auth_failed} =
               Sessions.authenticate(%{"email" => user.email, "password" => "123456789"})
    end

    test "it returns ok with user and token when auth succeeded" do
      user = insert(:user)

      assert {:ok, auth_user, jwt} =
               Sessions.authenticate(%{"email" => user.email, "password" => "12345678"})

      assert auth_user.id == user.id

      {
        :ok,
        %{"iat" => iat, "exp" => exp} = claims
      } = Guardian.decode_and_verify(jwt)

      assert exp == iat + 56 * 24 * 60 * 60

      assert {:ok, token_user} = Guardian.resource_from_claims(claims)
      assert token_user.id == user.id
    end
  end

  describe "Sessions.from_token/1" do
    test "it returns user if it still exists" do
      user = insert(:user)

      {:ok, jwt, _} =
        Guardian.encode_and_sign(
          user,
          %{},
          ttl: {1, :hours}
        )

      assert {:ok, token_user, _} = Sessions.from_token(jwt)
      assert token_user.id == user.id
    end
  end

  describe "Sessions.gen_token/1" do
    test "it returns error if user is nil" do
      assert {:error, :auth_failed} = Sessions.gen_token(nil)
    end

    test "it returns user and correct jwt token for existing user" do
      user = insert(:user)
      assert {:ok, auth_user, jwt} = Sessions.gen_token(user)
      assert {:ok, token_user, _} = Sessions.from_token(jwt)

      assert auth_user.id == user.id
      assert token_user.id == user.id
    end
  end
end
