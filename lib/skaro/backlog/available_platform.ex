defmodule Skaro.Backlog.AvailablePlatform do
  @moduledoc """
  Ecto schema for storing platforms that are available for backlog entry.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Skaro.Backlog.AvailablePlatform

  schema "backlog_available_platforms" do
    field(:platform_id, :integer)
    field(:platform_name, :string)

    belongs_to(:entry, Skaro.Backlog.Entry)

    timestamps()
  end

  @doc false
  def changeset(%AvailablePlatform{} = available_platform, attrs) do
    available_platform
    |> cast(attrs, [:platform_id, :platform_name, :entry_id])
  end
end
