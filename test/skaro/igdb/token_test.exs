defmodule Skaro.IGDB.TokenTest do
  @moduledoc false
  use Skaro.DataCase

  alias Plug.Conn
  alias Skaro.IGDB.Token

  describe "fetch/0" do
    @tag :bypass
    test "cache empty, ok response", %{igdb_api: igdb_api} do
      ConCache.delete(:external_api_cache, "igdb_api_token")

      Bypass.expect_once(
        igdb_api,
        "POST",
        "/oauth",
        fn conn ->
          {:ok, body, conn} = Conn.read_body(conn)

          assert "client_id=igdb_client_id&client_secret=igdb_client_secret&grant_type=client_credentials" ==
                   body

          Conn.resp(conn, 200, """
          {
            "access_token": "new_token",
            "expires_in": 1234
          }
          """)
        end
      )

      assert {:ok, "new_token"} == Token.fetch()
      assert "new_token" == ConCache.get(:external_api_cache, "igdb_api_token")
    end

    @tag :bypass
    test "cache empty, error response", %{igdb_api: igdb_api} do
      ConCache.delete(:external_api_cache, "igdb_api_token")
      Bypass.down(igdb_api)

      assert {:error, :econnrefused} == Token.fetch()
      assert nil == ConCache.get(:external_api_cache, "igdb_api_token")
    end
  end
end
