defmodule Skaro.Giantbomb.FranchisesParser do
  @moduledoc """
  Set of function to work with franchises data
  """
  alias Skaro.Core.Franchise

  def parse_many(nil), do: []
  def parse_many(franchises_json), do: Enum.map(franchises_json, &parse_minimal/1)

  def parse_minimal(franchise_json) do
    %Franchise{
      id: franchise_json["id"],
      external_id: franchise_json["id"],
      name: franchise_json["name"]
    }
  end
end
