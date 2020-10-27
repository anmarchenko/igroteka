defmodule Skaro.Howlongtobeat do
  @moduledoc """
  Entrypoint for HowLongToBeat functionality - finding and
  saving in the database times to beat for games
  """
  @behaviour Skaro.Playthrough.Remote

  alias Skaro.Howlongtobeat.Client

  def find(game) do
    Client.find(game)
  end

  def get_by_id(game_id) do
    Client.get_by_id(game_id)
  end
end
