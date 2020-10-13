defmodule Skaro.PlaythroughTimeRemote do
  @moduledoc """
  Behaviour that defines API to access remote info about games' length (HowLongToBeat)
  """

  @callback find(Map.t()) :: {:ok, Map.t()} | {:error, String.t()}
  @callback get_by_id(Integer.t()) :: {:ok, Map.t()} | {:error, String.t()}
end
