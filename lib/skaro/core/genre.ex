defmodule Skaro.Core.Genre do
  @moduledoc """
  Genre data model
  """

  @type t :: %__MODULE__{}

  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__

  schema "genres" do
    field(:name, :string)
    field(:external_id, :string)
    field(:external_url, :string)

    timestamps()
  end

  def changeset(%Genre{} = genre, attrs) do
    genre
    |> cast(attrs, [
      :name,
      :external_id,
      :external_url
    ])
    |> validate_required([:name, :external_id])
  end
end
