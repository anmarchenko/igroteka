defmodule Skaro.IGDB do
  @moduledoc """
  Set of functions to access IGDB's games API.
  """
  @behaviour Skaro.GamesRemote

  alias Skaro.HttpClient
  alias Skaro.IGDB.Parsers.Games, as: GamesParser
  alias Skaro.Parser

  def search(term) do
    with body when is_binary(body) <-
           HttpClient.idempotent_post(search_url(), search_query(term), headers()),
         {:ok, json} <- Parser.parse_json(body),
         :ok <- check_internal_error(json) do
      games =
        json
        |> Enum.map(& &1["game"])
        |> GamesParser.parse_basic()

      {:ok, games}
    else
      {:error, _} = error_tuple ->
        error_tuple
    end
  end

  def find_one(id) do
    with body when is_binary(body) <-
           HttpClient.idempotent_post(games_url(), game_by_id_query(id), headers()),
         {:ok, json} <- Parser.parse_json(body),
         :ok <- check_internal_error(json),
         [game] <- GamesParser.parse_full(json) do
      {:ok, game}
    else
      [] ->
        {:error, :not_found}

      {:error, _} = error_tuple ->
        error_tuple
    end
  end

  defp check_internal_error([%{"title" => error_title, "status" => status}]) do
    {:error, "Code #{status}, reason: #{error_title}"}
  end

  defp check_internal_error(_) do
    :ok
  end

  defp search_url, do: "#{api_url()}/search"
  defp games_url, do: "#{api_url()}/games"

  defp headers do
    [
      {"Accept", "application/json"},
      {"user-key", Application.fetch_env!(:skaro, :igdb)[:api_key]}
    ]
  end

  defp api_url, do: Application.fetch_env!(:skaro, :igdb)[:base_url]

  defp search_query(term) do
    """
    search "#{term}";
    where game != null & game.first_release_date != null;
    fields game.aggregated_rating,game.aggregated_rating_count,game.first_release_date,game.name,game.summary,game.url,game.cover.image_id,game.platforms.id,game.platforms.name;
    """
  end

  defp game_by_id_query(id) do
    """
    where id = #{id};
    fields aggregated_rating,aggregated_rating_count,first_release_date,name,summary,url,category,status,storyline,cover.image_id,platforms.*,franchises.*,involved_companies.developer,involved_companies.publisher,involved_companies.company.*,websites.*,involved_companies.company.logo.*;
    """
  end
end
