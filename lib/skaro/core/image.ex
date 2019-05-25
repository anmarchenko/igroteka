defmodule Skaro.Core.Image do
  @moduledoc """
  Image data model
  """

  @type t :: %__MODULE__{}

  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__

  schema "images" do
    field(:big_url, :string)
    field(:thumb_url, :string)

    timestamps()
  end

  def changeset(%Image{} = image, attrs) do
    image
    |> cast(attrs, [
      :big_url,
      :thumb_url
    ])
    |> validate_required([:big_url, :thumb_url])
  end
end
