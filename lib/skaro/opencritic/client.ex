defmodule Skaro.Opencritic.Client do
  @moduledoc """
  Opencritic client retrieves and parses information from https://opencritic.com/api
  """

  alias Skaro.{HttpClient, Parser}
  alias Skaro.Opencritic.Mapper
  alias Skaro.Tracing

  @event_call [:skaro, :opencritic, :call]
  @event_error [:skaro, :opencritic, :error]

  def find(%{name: nil}), do: {:error, "name is not given"}

  def find(%{name: name}) do
    case search(name) do
      {:ok, game_id} ->
        get_by_id(game_id)

      {:error, :not_found} ->
        record_error(:not_found)
        {:error, :not_found}

      {:error, _} = error_tuple ->
        record_error(:other)
        error_tuple
    end
  end

  def find(_), do: {:error, "argument is invalid"}

  def get_by_id(game_id) do
    trace(
      :get_by_id,
      fn ->
        with body when is_binary(body) <- HttpClient.get(game_url(game_id), %{}, headers()),
             {:ok, %{"numTopCriticReviews" => num} = game_json} when num > 0 <-
               Parser.parse_json(body),
             {:ok, cover_reviews} <- get_cover_reviews(game_id) do
          {:ok,
           Map.merge(
             %{
               external_id: Integer.to_string(game_json["id"]),
               tier: game_json["tier"],
               percent_recommended: game_json["percentRecommended"],
               score: game_json["topCriticScore"],
               num_reviews: game_json["numTopCriticReviews"]
             },
             cover_reviews
           )}
        else
          {:error, _} = error_tuple ->
            record_error(:other)
            error_tuple

          _ ->
            record_error(:not_found)
            {:error, :not_found}
        end
      end
    )
  end

  def get_cover_reviews(game_id) do
    trace(
      :get_cover_reviews,
      fn ->
        with body when is_binary(body) <- HttpClient.get(cover_url(game_id), %{}, headers()),
             {:ok, reviews} <- Parser.parse_json(body) do
          {:ok,
           %{
             reviews: Mapper.reviews(reviews)
           }}
        else
          {:error, _} = error_tuple ->
            error_tuple
        end
      end
    )
  end

  defp search(name) do
    trace(
      :search,
      fn ->
        with body when is_binary(body) <-
               HttpClient.get(search_url(), %{criteria: name}, headers()),
             {:ok, [%{"dist" => dist, "id" => game_id} | _]} when dist < 0.1 <-
               Parser.parse_json(body) do
          {:ok, game_id}
        else
          {:error, _} = error_tuple ->
            error_tuple

          _ ->
            {:error, :not_found}
        end
      end
    )
  end

  defp search_url, do: "#{base_url()}/game/search"
  defp game_url(game_id), do: "#{base_url()}/game/#{game_id}"
  defp cover_url(game_id), do: "#{base_url()}/review/game/#{game_id}"

  defp headers,
    do: [
      {"X-RapidAPI-Key", api_key()},
      {"X-RapidAPI-Host", "opencritic-api.p.rapidapi.com"}
    ]

  defp base_url, do: Application.fetch_env!(:skaro, :opencritic)[:base_url]

  defp api_key, do: Application.fetch_env!(:skaro, :opencritic)[:api_key]

  defp trace(action, fun) do
    Tracing.trace(@event_call, %{action: action}, fun)
  end

  defp record_error(reason) do
    Tracing.send_count(@event_error, 1, %{reason: reason})
  end
end
