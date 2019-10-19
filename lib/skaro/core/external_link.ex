defmodule Skaro.Core.ExternalLink do
  @moduledoc """
  Genre data model
  """

  @type t :: %__MODULE__{}

  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__
  alias Skaro.Core.Game

  @categories [
    "official",
    "wikia",
    "wikipedia",
    "facebook",
    "twitter",
    "twitch",
    "instagram",
    "youtube",
    "iphone",
    "ipad",
    "android",
    "steam",
    "reddit",
    "discord",
    "google_plus",
    "tumblr",
    "linkedin",
    "pinterest",
    "soundcloud"
  ]

  schema "external_links" do
    field(:url, :string)
    field(:category, :string)

    field(:external_id, :string)
    field(:external_category_id, :string)

    belongs_to(:game, Game)

    timestamps()
  end

  def changeset(%ExternalLink{} = external_link, attrs) do
    external_link
    |> cast(attrs, [
      :url,
      :category,
      :game_id,
      :external_id,
      :external_category_id
    ])
    |> validate_required([:url, :category])
    |> validate_inclusion(:category, @categories)
  end
end
