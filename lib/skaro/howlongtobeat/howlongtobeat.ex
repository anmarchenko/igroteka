defmodule Skaro.Howlongtobeat do
  @moduledoc """
  Entrypoint for HowLongToBeat functionality - finding and
  saving in the database times to beat for games
  """
  @behaviour Skaro.PlaythroughTimeRemote

  alias Skaro.Howlongtobeat.Client

  def find(game) do
    Client.find(game)
  end
end
