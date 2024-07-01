defmodule Skaro.GamesRemote do
  @moduledoc """
  Behaviour that defines API to access remote info about games (IGDB, Giantbomb, etc.)
  """

  @callback search(String.t()) :: {:ok, list(Skaro.Core.Game.t())} | {:error, String.t()}
  @callback find_one(String.t() | integer()) ::
              {:ok, Skaro.Core.Game.t()} | {:error, String.t()}
  @callback fetch_company(String.t() | integer()) ::
              {:ok, Skaro.Core.Company.t()} | {:error, String.t()}
  @callback top_games(map()) :: {:ok, list(Skaro.Core.Game.t())} | {:error, String.t()}
  @callback new_games() :: {:ok, list(Skaro.Core.Game.t())} | {:error, String.t()}
  @callback fetch_games(map()) :: {:ok, list(Skaro.Core.Game.t())} | {:error, String.t()}
  @callback get_screenshots(String.t() | integer()) ::
              {:ok, list(Skaro.Core.Image.t())} | {:error, String.t()}
end
