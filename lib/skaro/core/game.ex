defmodule Skaro.Core.Game do
  @moduledoc """
    Game data model
  """

  @type t :: %__MODULE__{}

  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__

  alias Skaro.Core.{
    Company,
    ExternalLink,
    Franchise,
    Genre,
    Image,
    Platform,
    Theme,
    Video
  }

  schema "games" do
    field(:name, :string)
    field(:external_id, :string)
    field(:external_url, :string)

    field(:short_description, :string)
    field(:description, :string)
    field(:release_date, :date)

    field(:rating, :float)
    field(:ratings_count, :integer)

    # main, DLC, expansion...
    field(:category, :integer)
    # release, alpha, beta...
    field(:status, :integer)

    field(:ttb_hastly, :integer)
    field(:ttb_normally, :integer)
    field(:ttb_completely, :integer)

    belongs_to(:cover, Image)

    has_many(:external_links, ExternalLink)
    has_many(:videos, Video)

    many_to_many(:platforms, Platform,
      join_through: "games_platforms",
      on_replace: :delete
    )

    many_to_many(:publishers, Company,
      join_through: "games_publishers",
      on_replace: :delete
    )

    many_to_many(:developers, Company,
      join_through: "games_developers",
      on_replace: :delete
    )

    many_to_many(:genres, Genre, join_through: "games_genres", on_replace: :delete)
    many_to_many(:themes, Theme, join_through: "games_themes", on_replace: :delete)

    many_to_many(:franchises, Franchise,
      join_through: "games_franchises",
      on_replace: :delete
    )

    timestamps()
  end

  def changeset(%Game{} = game, attrs) do
    game
    |> cast(attrs, [
      :name,
      :external_id,
      :external_url,
      :short_description,
      :description,
      :release_date,
      :rating,
      :ratings_count,
      :category,
      :status,
      :ttb_hastly,
      :ttb_normally,
      :ttb_completely
    ])
    |> cast_assoc(:cover)
    |> cast_assoc(:external_links)
    |> validate_required([:name, :external_id])
  end
end
