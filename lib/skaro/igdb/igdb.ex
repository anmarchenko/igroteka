defmodule Skaro.IGDB do
  @moduledoc """
  Set of functions to access IGDB's games API.
  """
  @behaviour Skaro.GamesRemote

  alias Skaro.HttpClient
  alias Skaro.IGDB.Parsers.Games, as: GamesParser
  alias Skaro.IGDB.Parsers.Images, as: ImagesParser
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

  def get_screenshots(game_id) do
    with body when is_binary(body) <-
           HttpClient.idempotent_post(
             screenshots_url(),
             screenshots_by_game_id_query(game_id),
             headers()
           ),
         {:ok, json} <- Parser.parse_json(body),
         :ok <- check_internal_error(json),
         screenshots <- ImagesParser.parse_screenshot(json) do
      {:ok, screenshots}
    else
      {:error, _} = error_tuple ->
        error_tuple
    end
  end

  def top_games(filters) do
    with body when is_binary(body) <-
           HttpClient.idempotent_post(
             games_url(),
             top_games_query(filters),
             headers()
           ),
         {:ok, json} <- Parser.parse_json(body),
         :ok <- check_internal_error(json),
         games <- GamesParser.parse_basic(json) do
      {:ok, games}
    else
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
  defp screenshots_url, do: "#{api_url()}/screenshots"

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

  defp top_games_query(filters) do
    """
    #{top_games_filters(filters)};
    sort aggregated_rating desc;
    limit 100;
    fields name,aggregated_rating,aggregated_rating_count,first_release_date,summary,url,cover.image_id,platforms.id,platforms.name;
    """
  end

  defp game_by_id_query(id) do
    """
    where id = #{id};
    fields aggregated_rating,aggregated_rating_count,first_release_date,name,summary,url,category,status,storyline,cover.image_id,platforms.*,franchises.*,involved_companies.developer,involved_companies.publisher,involved_companies.company.*,websites.*,involved_companies.company.logo.*,videos.video_id,videos.name;
    """
  end

  defp screenshots_by_game_id_query(game_id) do
    """
    where game = #{game_id};
    fields image_id;
    """
  end

  defp top_games_filters(filters) do
    ("where version_parent = null & category=0 & first_release_date != null " <>
       "& aggregated_rating != null & aggregated_rating_count > 5 & aggregated_rating > 79" <>
       "& name != \"The Witness\"")
    |> filter_if_present(:platform, filters)
    |> filter_if_present(:year, filters)
  end

  defp filter_if_present(filter, :platform, %{"platform" => platform}) when platform != nil do
    filter <> " & platforms = (#{platform})"
  end

  defp filter_if_present(filter, :year, %{"year" => year}) when year != nil and is_binary(year) do
    {year, _} = Integer.parse(year)
    filter_if_present(filter, :year, %{"year" => year})
  end

  defp filter_if_present(filter, :year, %{"year" => year})
       when year != nil and is_integer(year) do
    {:ok, start, 0} = DateTime.from_iso8601("#{year}-01-01T00:00:00Z")
    {:ok, fin, 0} = DateTime.from_iso8601("#{year + 1}-01-01T00:00:00Z")

    filter <>
      " & first_release_date >= #{DateTime.to_unix(start)} & first_release_date < #{
        DateTime.to_unix(fin)
      }"
  end

  defp filter_if_present(filter, _, _), do: filter
end
