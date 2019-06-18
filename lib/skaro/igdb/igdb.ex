defmodule Skaro.IGDB do
  @moduledoc """
  Set of functions to access IGDB's games API.
  """
  @behaviour Skaro.GamesRemote

  @api_url "https://api-v3.igdb.com"

  alias Skaro.HttpClient
  alias Skaro.IGDB.Parsers.Games, as: GamesParser

  def search(term) do
    search_url()
    |> HttpClient.idempotent_post(search_query(term), headers())
    |> check_error_state()
    |> GamesParser.parse_many()
  end

  def find_one(_id) do
    %{}
    # base_params()
    # |> Map.put("field_list", @full_game_fields)
    # |> HttpClient.get(game_url(id))
    # |> check_error_state()
    # |> GamesParser.parse_one()
  end

  defp check_error_state({:error, reason}), do: {:error, reason}

  defp check_error_state({:ok, [%{"title" => error_title, "status" => status}]}) do
    {:error, "Code #{status}, reason: #{error_title}"}
  end

  defp check_error_state({:ok, json}) do
    {:ok, json}
  end

  defp search_url(), do: "#{@api_url}/search"

  defp headers() do
    [
      {"Accept", "application/json"},
      {"user-key", Application.fetch_env!(:skaro, :igdb)[:api_key]}
    ]
  end

  defp search_query(term) do
    """
    search "#{term}";
    where game != null & (game.version_parent = null | game.version_title = "Remake" | game.version_title = "Remaster") & game.category=0 & game.first_release_date != null;
    fields game.aggregated_rating,game.aggregated_rating_count,game.first_release_date,game.name,game.summary,game.cover.image_id,game.platforms.id,game.platforms.name;
    """
  end
end
