defmodule Skaro.Reviews.Remote do
  @moduledoc """
  Behaviour that defines API to access remote info about critic reviews (Opencritic)
  """

  @callback find(Map.t()) :: {:ok, Map.t()} | {:error, String.t()}
  @callback get_by_id(Integer.t()) :: {:ok, Map.t()} | {:error, String.t()}
end
