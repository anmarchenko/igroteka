defmodule Skaro.Opencritic do
  @moduledoc """
  Entrypoint for Opencritic functionality - finding and
  saving in the database critic ratings and reviews
  """
  @behaviour Skaro.Reviews.Remote

  alias Skaro.Opencritic.Client

  @spec find(%{name: String.t()}) :: {:ok, map()} | {:error, String.t()}
  def find(game) do
    Client.find(game)
  end

  @spec get_by_id(integer()) :: {:ok, map()} | {:error, String.t()}
  def get_by_id(game_id) do
    Client.get_by_id(game_id)
  end
end
