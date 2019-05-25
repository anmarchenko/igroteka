defmodule Skaro.Giantbomb do
  @moduledoc """
  Set of functions to access Giantbomb's games API.
  """

  @behaviour Skaro.GamesRemote

  @minimal_game_fields "deck,name,id,image,original_release_date,platforms"
  @full_game_fields "deck,name,id,image,original_release_date,platforms," <>
                      "description,images,developers,publishers,franchises,genres,themes"

  alias Skaro.Giantbomb.GamesParser
  alias Skaro.HttpClient

  def search(term) do
    base_params()
    |> Map.put("resources", "game")
    |> Map.put("query", term)
    |> Map.put("field_list", @minimal_game_fields)
    |> HttpClient.get(search_url())
    |> check_error_state()
    |> GamesParser.parse_many()
  end

  def find_one(id) do
    base_params()
    |> Map.put("field_list", @full_game_fields)
    |> HttpClient.get(game_url(id))
    |> check_error_state()
    |> GamesParser.parse_one()
  end

  defp check_error_state({:error, reason}), do: {:error, reason}

  defp check_error_state({:ok, json}) do
    case json["error"] do
      "OK" ->
        {:ok, json}

      reason ->
        {:error, reason}
    end
  end

  defp search_url, do: "#{base_url()}/search/"
  defp game_url(id), do: "#{base_url()}/game/#{id}/"

  defp base_url, do: Application.fetch_env!(:skaro, :giantbomb)[:base_url]

  defp base_params do
    %{
      "api_key" => Application.fetch_env!(:skaro, :giantbomb)[:api_key],
      "format" => "json"
    }
  end
end
