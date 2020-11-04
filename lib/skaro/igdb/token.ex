defmodule Skaro.IGDB.Token do
  @moduledoc """
  Fetching and caching OAuth token for IGDB API
  """

  alias Skaro.HttpClient

  @cache_key "igdb_api_token"

  def fetch do
    case ConCache.get(:external_api_cache, @cache_key) do
      nil ->
        fetch_token_from_remote()

      token ->
        {:ok, token}
    end
  end

  defp fetch_token_from_remote do
    with body when is_binary(body) <-
           HttpClient.idempotent_post(
             oauth_url(),
             {:form,
              [
                {:client_id, client_id()},
                {:client_secret, client_secret()},
                {:grant_type, "client_credentials"}
              ]},
             []
           ),
         {:ok, %{"access_token" => token, "expires_in" => expires_in}} <- Jason.decode(body) do
      ConCache.put(:external_api_cache, @cache_key, %ConCache.Item{
        value: token,
        ttl: expires_in - 60
      })

      {:ok, token}
    else
      {:error, _} = error_tuple ->
        error_tuple

      {:ok, json} ->
        {:error, "Unknown oauth2 response: #{inspect(json)}"}
    end
  end

  defp oauth_url, do: Application.fetch_env!(:skaro, :igdb)[:oauth_url]
  defp client_id, do: Application.fetch_env!(:skaro, :igdb)[:client_id]
  defp client_secret, do: Application.fetch_env!(:skaro, :igdb)[:client_secret]
end
