defmodule Skaro.IGDB do
  @moduledoc """
  Set of functions to access IGDB's games API.
  """
  @behaviour Skaro.GamesRemote

  alias Skaro.HttpClient
  alias Skaro.IGDB.Parsers.Companies, as: CompaniesParser
  alias Skaro.IGDB.Parsers.Games, as: GamesParser
  alias Skaro.IGDB.Parsers.Images, as: ImagesParser
  alias Skaro.IGDB.Token
  alias Skaro.Parser
  alias Skaro.Tracing

  @spec search(binary()) :: {:error, binary()} | {:ok, [Skaro.Core.Game.t()]}
  def search(term) do
    trace(
      "search",
      fn ->
        case fetch_data(search_url(), search_query(term)) do
          {:ok, json} ->
            games =
              json
              |> Enum.map(& &1["game"])
              |> GamesParser.parse_basic()

            {:ok, games}

          {:error, _} = error_tuple ->
            :telemetry.execute([:skaro, :igdb, :error], %{count: 1}, %{action: "search"})

            error_tuple
        end
      end
    )
  end

  def fetch_games(filters) do
    trace(
      "fetch_games",
      fn ->
        with {:ok, json} <- fetch_data(games_url(), games_query(filters)),
             games <- GamesParser.parse_basic(json) do
          {:ok, games}
        else
          {:error, _} = error_tuple ->
            report_error("fetch_games")

            error_tuple
        end
      end
    )
  end

  def find_one(id) do
    trace(
      "find_one",
      fn ->
        with {:ok, json} <- fetch_data(games_url(), game_by_id_query(id)),
             [game] <- GamesParser.parse_full(json) do
          {:ok, game}
        else
          [] ->
            {:error, :not_found}

          {:error, _} = error_tuple ->
            report_error("find_one")
            error_tuple
        end
      end
    )
  end

  def get_screenshots(game_id) do
    trace(
      "get_screenshots",
      fn ->
        with {:ok, json} <-
               fetch_data(
                 screenshots_url(),
                 screenshots_by_game_id_query(game_id)
               ),
             screenshots <- ImagesParser.parse_screenshot(json) do
          {:ok, screenshots}
        else
          {:error, _} = error_tuple ->
            report_error("get_screenshots")

            error_tuple
        end
      end
    )
  end

  def top_games(filters) do
    trace(
      "top_games",
      fn ->
        with {:ok, json} <- fetch_data(games_url(), top_games_query(filters)),
             games <- GamesParser.parse_basic(json) do
          {:ok, games}
        else
          {:error, _} = error_tuple ->
            report_error("top_games")

            error_tuple
        end
      end
    )
  end

  def new_games do
    trace(
      "new_games",
      fn ->
        with {:ok, json} <- fetch_data(games_url(), new_games_query()),
             games <- GamesParser.parse_basic(json) do
          {:ok, games}
        else
          {:error, _} = error_tuple ->
            report_error("new_games")

            error_tuple
        end
      end
    )
  end

  def fetch_company(id) do
    trace(
      "fetch_company",
      fn ->
        with {:ok, json} <- fetch_data(companies_url(), company_by_id_query(id)),
             [company] <- CompaniesParser.parse_full(json) do
          {:ok, company}
        else
          [] ->
            report_error("fetch_company")

            {:error, :not_found}

          {:error, _} = error_tuple ->
            report_error("fetch_company")

            error_tuple
        end
      end
    )
  end

  @event_error [:skaro, :igdb, :error]
  def report_error(action) do
    Tracing.send_count(@event_error, %{action: action})
  end

  @event_call [:skaro, :igdb, :call]
  def trace(action, fun) do
    Tracing.trace(@event_call, %{action: action}, fun)
  end

  defp fetch_data(url, query) do
    with body when is_binary(body) <-
           HttpClient.idempotent_post(url, query, headers()),
         {:ok, json} <- Parser.parse_json(body),
         :ok <- check_internal_error(json) do
      {:ok, json}
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
  defp companies_url, do: "#{api_url()}/companies"
  defp screenshots_url, do: "#{api_url()}/screenshots"

  defp headers do
    [
      {"Accept", "application/json"},
      {"Authorization", "Bearer #{token()}"},
      {"Client-ID", client_id()}
    ]
  end

  defp api_url, do: Application.fetch_env!(:skaro, :igdb)[:base_url]
  defp client_id, do: Application.fetch_env!(:skaro, :igdb)[:client_id]

  defp token do
    {:ok, token} = Token.fetch()
    token
  end

  defp search_query(term) do
    """
    search "#{term}";
    where game != null & game.first_release_date != null;
    fields game.aggregated_rating,game.aggregated_rating_count,game.first_release_date,game.name,game.summary,
    game.url,game.cover.image_id,
    game.involved_companies.developer,game.involved_companies.publisher,
    game.involved_companies.company.id,game.involved_companies.company.name,game.involved_companies.company.url,
    game.involved_companies.company.country;
    """
  end

  defp top_games_query(filters) do
    """
    #{top_games_filters(filters)};
    sort aggregated_rating desc;
    limit 100;
    fields name,aggregated_rating,aggregated_rating_count,first_release_date,summary,url,cover.image_id,
    involved_companies.developer,involved_companies.publisher,
    involved_companies.company.id,involved_companies.company.name,involved_companies.company.url,
    involved_companies.company.country;
    """
  end

  defp new_games_query do
    """
    where first_release_date != null & aggregated_rating != null & aggregated_rating_count > 5 & aggregated_rating > 79;
    sort first_release_date desc;
    limit 30;
    fields name,aggregated_rating,aggregated_rating_count,first_release_date,summary,url,cover.image_id,
    involved_companies.developer,involved_companies.publisher,
    involved_companies.company.id,involved_companies.company.name,involved_companies.company.url,
    involved_companies.company.country;
    """
  end

  defp games_query(filters) do
    """
    #{fetch_games_filters(filters)};
    sort first_release_date desc;
    limit 50; offset #{filters["offset"]};
    fields name,aggregated_rating,aggregated_rating_count,first_release_date,summary,url,cover.image_id,
    involved_companies.developer,involved_companies.publisher,
    involved_companies.company.id,involved_companies.company.name,involved_companies.company.url,
    involved_companies.company.country;
    """
  end

  defp game_by_id_query(id) do
    """
    where id = #{id};
    fields aggregated_rating,aggregated_rating_count,first_release_date,name,summary,url,category,status,
    storyline,cover.image_id,platforms.*,franchises.*,websites.*,videos.video_id,videos.name,themes.*,genres.*,
    involved_companies.developer,involved_companies.publisher,
    involved_companies.company.id,involved_companies.company.name,involved_companies.company.url,
    involved_companies.company.country,involved_companies.company.logo.*;
    """
  end

  defp screenshots_by_game_id_query(game_id) do
    """
    where game = #{game_id};
    fields image_id;
    """
  end

  defp company_by_id_query(id) do
    """
    where id = #{id};
    fields id,name,country,description,logo.*,start_date,url,websites.*;
    """
  end

  defp fetch_games_filters(filters) do
    "where first_release_date != null "
    |> filter_if_present(:developer, filters)
    |> filter_if_present(:publisher, filters)
  end

  defp top_games_filters(filters) do
    ("where first_release_date != null " <>
       "& aggregated_rating != null & aggregated_rating_count > 9 & aggregated_rating > 79" <>
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
      " & first_release_date >= #{DateTime.to_unix(start)} & first_release_date < #{DateTime.to_unix(fin)}"
  end

  defp filter_if_present(filter, :developer, %{"developer" => developer}) when developer != nil do
    filter <> " & involved_companies.company = #{developer} & involved_companies.developer = true"
  end

  defp filter_if_present(filter, :publisher, %{"publisher" => publisher}) when publisher != nil do
    filter <> " & involved_companies.company = #{publisher} & involved_companies.publisher = true"
  end

  defp filter_if_present(filter, _, _), do: filter
end
