defmodule Skaro.Core.Company do
  @moduledoc """
    Company (developer/publisher) data model
  """

  @type t :: %__MODULE__{}

  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__

  alias Skaro.Core.Image

  schema "companies" do
    field(:name, :string)
    field(:external_id, :string)
    field(:external_url, :string)
    field(:website, :string)

    field(:description, :string)
    field(:country, :string)
    field(:start_date, :date)

    belongs_to(:logo, Image)

    timestamps()
  end

  def changeset(%Company{} = company, attrs) do
    company
    |> cast(attrs, [
      :name,
      :website,
      :external_id,
      :external_url,
      :description,
      :country,
      :start_date
    ])
    |> validate_required([:name, :external_id])
  end
end
