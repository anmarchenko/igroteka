defmodule Skaro.DataCase do
  @moduledoc """
  This module defines the setup for tests requiring
  access to the application's data layer.

  You may define functions here to be used as helpers in
  your tests.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  alias Ecto.Adapters.SQL.Sandbox

  using do
    quote do
      alias Skaro.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Skaro.DataCase
    end
  end

  setup tags do
    :ok = Sandbox.checkout(Skaro.Repo)

    {igdb_api, howlongtobeat, opencritic} = setup_bypass(tags[:bypass])

    unless tags[:async] do
      Sandbox.mode(Skaro.Repo, {:shared, self()})
    end

    ConCache.put(:external_api_cache, "igdb_api_token", "igdb_api_token")

    {:ok, igdb_api: igdb_api, howlongtobeat: howlongtobeat, opencritic: opencritic}
  end

  defp setup_bypass(nil), do: {nil, nil, nil}

  defp setup_bypass(true) do
    igdb_api = Bypass.open(port: 1235)

    Application.put_env(
      :skaro,
      :igdb,
      base_url: "http://localhost:#{igdb_api.port}",
      oauth_url: "http://localhost:#{igdb_api.port}/oauth",
      client_id: "igdb_client_id",
      client_secret: "igdb_client_secret"
    )

    howlongtobeat = Bypass.open(port: 1236)

    Application.put_env(
      :skaro,
      :howlongtobeat,
      base_url: "http://localhost:#{howlongtobeat.port}"
    )

    opencritic = Bypass.open(port: 1237)

    Application.put_env(
      :skaro,
      :opencritic,
      base_url: "http://localhost:#{opencritic.port}",
      api_key: "opencritic_api_key"
    )

    {igdb_api, howlongtobeat, opencritic}
  end

  @doc """
  A helper that transforms changeset errors into a map of messages.

      assert {:error, changeset} = Accounts.create_user(%{password: "short"})
      assert "password is too short" in errors_on(changeset).password
      assert %{password: ["password is too short"]} = errors_on(changeset)

  """
  def errors_on(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
      Enum.reduce(opts, message, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
