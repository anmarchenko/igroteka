defmodule Skaro.Core.Platform do
  @moduledoc """
  Platform data model
  """

  @type t :: %__MODULE__{}

  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__

  schema "platforms" do
    field(:name, :string)
    field(:alternative_name, :string)
    field(:generation, :integer)
    field(:summary, :string)
    field(:website, :string)

    field(:external_id, :string)
    field(:external_url, :string)

    timestamps()
  end

  def changeset(%Platform{} = platform, attrs) do
    platform
    |> cast(attrs, [
      :name,
      :alternative_name,
      :generation,
      :summary,
      :website,
      :external_id,
      :external_url
    ])
    |> validate_required([:name, :external_id])
  end
end
