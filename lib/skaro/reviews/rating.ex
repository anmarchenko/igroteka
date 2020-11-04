defmodule Skaro.Reviews.Rating do
  @moduledoc """
  DB model with critic ratings and reviews
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__

  @type t :: %__MODULE__{}

  schema "ratings" do
    field(:external_id, :string)

    field(:percent_recommended, :float)
    field(:score, :float)
    field(:num_reviews, :integer)

    field(:tier, :string)
    field(:summary, :string)
    field(:reviews, {:array, :map})
    field(:points, {:array, :map})

    field(:game_id, :integer)
    field(:game_name, :string)

    timestamps()
  end

  def changeset(%Rating{} = rating, attrs) do
    rating
    |> cast(attrs, [
      :external_id,
      :percent_recommended,
      :score,
      :num_reviews,
      :tier,
      :summary,
      :reviews,
      :points,
      :game_id,
      :game_name
    ])
    |> validate_required([:game_id, :external_id])
  end

  def changeset_update(%Rating{} = rating, attrs) do
    rating
    |> cast(attrs, [
      :percent_recommended,
      :score,
      :num_reviews,
      :tier,
      :summary,
      :reviews,
      :points
    ])
    |> validate_required([:score])
  end
end
