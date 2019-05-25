defmodule Skaro.Core.ExternalLink do
  @moduledoc """
  Genre data model
  """

  @type t :: %__MODULE__{}

  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__
  alias Skaro.Core.Game

  schema "external_links" do
    field(:url, :string)
    field(:category_id, :string)

    belongs_to(:game, Game)

    timestamps()
  end

  def changeset(%ExternalLink{} = external_link, attrs) do
    external_link
    |> cast(attrs, [
      :url,
      :category_id,
      :game_id
    ])
    |> validate_required([:url, :category_id])
  end
end
