defmodule Skaro.Core.Franchise do
  @moduledoc """
    Franchise data model
  """

  @type t :: %__MODULE__{}

  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__

  schema "franchises" do
    field(:name, :string)
    field(:external_id, :string)
    field(:external_url, :string)

    timestamps()
  end

  def changeset(%Franchise{} = franchise, attrs) do
    franchise
    |> cast(attrs, [
      :name,
      :external_id,
      :external_url
    ])
    |> validate_required([:name, :external_id])
  end
end
