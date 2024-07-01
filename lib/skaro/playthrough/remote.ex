defmodule Skaro.Playthrough.Remote do
  @moduledoc """
  Behaviour that defines API to access remote info about games' length (HowLongToBeat)
  """

  @callback find(map()) :: {:ok, map()} | {:error, String.t()}
  @callback get_by_id(integer()) :: {:ok, map()} | {:error, String.t()}
end
