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
  alias Skaro.Parser

  def search(term) do
    search_params =
      base_params()
      |> Map.put("resources", "game")
      |> Map.put("query", term)
      |> Map.put("field_list", @minimal_game_fields)

    with body when is_binary(body) <- HttpClient.get(search_params, search_url()),
         {:ok, json} <- Parser.parse_json(body),
         :ok <- check_error_state(json) do
      GamesParser.parse_many(json)
    else
      {:error, _} = error_tuple ->
        error_tuple
    end
  end

  def find_one(id) do
    find_params =
      base_params()
      |> Map.put("field_list", @full_game_fields)

    with body <- HttpClient.get(find_params, game_url(id)),
         {:ok, json} <- Parser.parse_json(body),
         :ok <- check_error_state(json) do
      GamesParser.parse_one(json)
    else
      {:error, _} = error_tuple ->
        error_tuple
    end
  end

  # this is not implemented for Giantbomb
  def get_screenshots(_), do: {:ok, []}
  def top_games(_), do: {:ok, []}

  defp check_error_state(json) do
    case json["error"] do
      "OK" ->
        :ok

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
