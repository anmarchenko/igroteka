defmodule Skaro.Core.Theme do
  @moduledoc """
  Theme data model
  """

  @type t :: %__MODULE__{}

  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__

  schema "themes" do
    field(:name, :string)
    field(:external_id, :string)
    field(:external_url, :string)

    timestamps()
  end

  def changeset(%Theme{} = theme, attrs) do
    theme
    |> cast(attrs, [
      :name,
      :external_id,
      :external_url
    ])
    |> validate_required([:name, :external_id])
  end
end
