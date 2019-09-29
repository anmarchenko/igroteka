defmodule Skaro.Backlog.Entry do
  @moduledoc """
  Schema representing backlog entry
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Skaro.Backlog.Entry

  @statuses ["wishlist", "backlog", "playing", "beaten"]

  schema "backlog_entries" do
    field(:game_id, :integer)
    field(:game_name, :string)
    field(:game_release_date, :date)
    field(:poster_thumb_url, :string)

    field(:status, :string)
    field(:note, :string)
    field(:owned_platform_id, :integer)
    field(:owned_platform_name, :string)
    field(:score, :integer)
    field(:expectation_rating, :integer)
    field(:finished_at, :date)

    belongs_to(:user, Skaro.Accounts.User)
    has_many(:available_platforms, Skaro.Backlog.AvailablePlatform)

    timestamps()
  end

  def statuses, do: @statuses

  @doc false
  def changeset(%Entry{} = entry, attrs) do
    entry
    |> cast(attrs, [
      :game_id,
      :game_name,
      :poster_thumb_url,
      :game_release_date,
      :user_id,
      :status,
      :note,
      :expectation_rating,
      :score
    ])
    |> cast_assoc(:available_platforms)
    |> validate_required([:game_id, :game_name, :user_id, :status])
    |> validate_inclusion(:status, @statuses)
    |> unique_constraint(
      :game_id,
      name: :backlog_entries_unique_user_id_game_id_index
    )
  end

  def update(%Entry{} = entry, attrs) do
    entry
    |> cast(attrs, [
      :status,
      :score,
      :owned_platform_id,
      :owned_platform_name,
      :finished_at,
      :note,
      :expectation_rating
    ])
    |> validate_required([:status])
    |> validate_inclusion(:status, @statuses)
  end

  def migrate(%Entry{} = entry, attrs) do
    entry
    |> cast(attrs, [
      :game_id,
      :game_name,
      :poster_thumb_url,
      :game_release_date,
      :owned_platform_id,
      :owned_platform_name
    ])
    |> cast_assoc(:available_platforms)
  end
end
