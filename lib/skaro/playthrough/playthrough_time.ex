defmodule Skaro.Playthrough.PlaythroughTime do
  @moduledoc """
  PlaythroughTime data model
  """

  @type t :: %__MODULE__{}

  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__

  schema "playthrough_times" do
    field(:external_id, :string)
    field(:external_url, :string)

    field(:main, :integer)
    field(:main_extra, :integer)
    field(:completionist, :integer)

    field(:game_id, :integer)
    field(:game_name, :string)

    timestamps()
  end

  def changeset(%PlaythroughTime{} = ptime, attrs) do
    ptime
    |> cast(attrs, [
      :main,
      :main_extra,
      :completionist,
      :game_id,
      :game_name,
      :external_id,
      :external_url
    ])
    |> validate_required([:game_id, :external_id])
  end

  def changeset_update(%PlaythroughTime{} = ptime, attrs) do
    ptime
    |> cast(attrs, [
      :main,
      :main_extra,
      :completionist
    ])
    |> validate_required([:main])
  end
end
