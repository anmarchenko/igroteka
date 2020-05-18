defmodule Skaro.GamesRemote do
  @moduledoc """
  Behaviour that defines API to access remote info about games (IGDB, Giantbomb, etc.)
  """

  @callback search(String.t()) :: {:ok, list(Skaro.Core.Game.t())} | {:error, String.t()}
  @callback find_one(String.t() | Integer.t()) ::
              {:ok, Skaro.Core.Game.t()} | {:error, String.t()}
  @callback get_screenshots(String.t() | Integer.t()) ::
              {:ok, list(Skaro.Core.Image.t())} | {:error, String.t()}
end
