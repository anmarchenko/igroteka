defmodule Skaro.Howlongtobeat do
  @moduledoc """
  Entrypoint for HowLongToBeat functionality - finding and
  saving in the database times to beat for games
  """
  @behaviour Skaro.Playthrough.Remote

  alias Skaro.Howlongtobeat.Client

  @spec find(%{name: String.t(), release_date: Date.t()}) :: {:ok, map()} | {:error, String.t()}
  def find(game) do
    Client.find(game)
  end

  @spec get_by_id(Integer.t()) :: {:ok, map()} | {:error, String.t()}
  def get_by_id(game_id) do
    Client.get_by_id(game_id)
  end
end
