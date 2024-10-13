defmodule Skaro.Opencritic.Client do
  @moduledoc """
  Opencritic client retrieves and parses information from https://opencritic.com/api
  """

  alias Skaro.{HttpClient, Parser}
  alias Skaro.Opencritic.Mapper

  require OpenTelemetry.Tracer, as: Tracer

  def find(%{name: nil}), do: {:error, "name is not given"}

  def find(%{name: name}) do
    Tracer.with_span "opencritic.client.find", kind: :client, attributes: %{game_name: name} do
      case search(name) do
        {:ok, game_id} ->
          get_by_id(game_id)

        {:error, :not_found} ->
          {:error, :not_found}

        {:error, _} = error_tuple ->
          error_tuple
      end
    end
  end

  def find(_), do: {:error, "argument is invalid"}

  def get_by_id(game_id) do
    Tracer.with_span "opencritic.client.get_by_id", kind: :client, attributes: %{game_id: game_id} do
      with body when is_binary(body) <- HttpClient.get(game_url(game_id), %{}, headers()),
           {:ok, %{"numTopCriticReviews" => num} = game_json} when num > 0 <-
             Parser.parse_json(body),
           {:ok, cover_reviews} <- get_cover_reviews(game_id) do
        Tracer.set_attribute(:result, :ok)

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
        {:error, reason} = error_tuple ->
          Tracer.set_attribute(:result, :external_api_failure)

          Tracer.set_status(OpenTelemetry.status(:error, "OpenCritic API call failed: #{reason}"))

          error_tuple

        _ ->
          Tracer.set_attribute(:result, :opencritic_reviews_not_found)

          {:error, :not_found}
      end
    end
  end

  def get_cover_reviews(game_id) do
    Tracer.with_span "opencritic.client.get_cover_reviews",
      kind: :client,
      attributes: %{game_id: game_id} do
      with body when is_binary(body) <- HttpClient.get(cover_url(game_id), %{}, headers()),
           {:ok, reviews} <- Parser.parse_json(body) do
        Tracer.set_attribute(:result, :ok)

        {:ok,
         %{
           reviews: Mapper.reviews(reviews)
         }}
      else
        {:error, reason} = error_tuple ->
          Tracer.set_attribute(:result, :external_api_failure)

          Tracer.set_status(OpenTelemetry.status(:error, "OpenCritic API call failed: #{reason}"))

          error_tuple
      end
    end
  end

  defp search(name) do
    Tracer.with_span "opencritic.client.search", kind: :client, attributes: %{game_name: name} do
      with body when is_binary(body) <-
             HttpClient.get(search_url(), %{criteria: name}, headers()),
           {:ok, [%{"dist" => dist, "id" => game_id} | _]} when dist < 0.1 <-
             Parser.parse_json(body) do
        Tracer.set_attribute(:result, :ok)

        {:ok, game_id}
      else
        {:error, reason} = error_tuple ->
          Tracer.set_attribute(:result, :external_api_failure)

          Tracer.set_status(OpenTelemetry.status(:error, "OpenCritic API call failed: #{reason}"))

          error_tuple

        _ ->
          Tracer.set_attribute(:result, :game_not_found_in_opencritic)

          {:error, :not_found}
      end
    end
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
end
