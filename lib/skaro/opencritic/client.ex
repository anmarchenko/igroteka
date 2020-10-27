defmodule Skaro.Opencritic.Client do
  @moduledoc """
  Opencritic client retrieves and parses information from https://opencritic.com
  """

  alias Skaro.{HttpClient, Parser}

  def find(%{name: nil}), do: {:error, "name is not given"}

  def find(%{name: name}) do
    with body when is_binary(body) <-
           HttpClient.get(search_url(), %{criteria: name}),
         {:ok, [%{"dist" => dist, "id" => game_id} | _]} when dist < 0.1 <-
           Parser.parse_json(body) do
      get_by_id(game_id)
    else
      {:error, _} = error_tuple ->
        error_tuple

      _ ->
        {:error, :not_found}
    end
  end

  def find(_), do: {:error, "argument is invalid"}

  def get_by_id(game_id) do
    with body when is_binary(body) <- HttpClient.get(game_url(game_id)),
         {:ok, %{"numTopCriticReviews" => num} = game_json} when num > 0 <-
           Parser.parse_json(body) do
      %{
        percent_recommended: game_json["percentRecommended"],
        top_critic_score: game_json["topCriticScore"],
        num_top_critic_reviews: game_json["numTopCriticReviews"],
        tier: game_json["tier"],
        name: game_json["name"],
        opencritic_id: game_json["id"]
      }
    else
      {:error, _} = error_tuple ->
        error_tuple

      _ ->
        {:error, :not_found}
    end
  end

  defp search_url(), do: "#{base_url()}/game/search"
  defp game_url(game_id), do: "#{base_url()}/game/#{game_id}"

  defp base_url, do: Application.fetch_env!(:skaro, :opencritic)[:base_url]
end
