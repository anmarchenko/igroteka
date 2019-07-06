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

  def find_one(_id) do
    %{}
    # base_params()
    # |> Map.put("field_list", @full_game_fields)
    # |> HttpClient.get(game_url(id))
    # |> check_error_state()
    # |> GamesParser.parse_one()
  end

  defp check_internal_error([%{"title" => error_title, "status" => status}]) do
    {:error, "Code #{status}, reason: #{error_title}"}
  end

  defp check_internal_error(_) do
    :ok
  end

  defp search_url(), do: "#{api_url()}/search"

  defp headers() do
    [
      {"Accept", "application/json"},
      {"user-key", Application.fetch_env!(:skaro, :igdb)[:api_key]}
    ]
  end

  defp api_url(), do: Application.fetch_env!(:skaro, :igdb)[:base_url]

  defp search_query(term) do
    """
    search "#{term}";
    where game != null & game.category=0 & game.first_release_date != null;
    fields game.aggregated_rating,game.aggregated_rating_count,game.first_release_date,game.name,game.summary,game.cover.image_id,game.platforms.id,game.platforms.name;
    """
  end
end
