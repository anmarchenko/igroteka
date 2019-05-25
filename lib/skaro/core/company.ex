defmodule Skaro.Core.Company do
  @moduledoc """
    Company (developer/publisher) data model
  """

  @type t :: %__MODULE__{}

  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__

  schema "companies" do
    field(:name, :string)
    field(:external_id, :string)
    field(:external_url, :string)
    field(:website, :string)

    field(:description, :string)
    field(:twitter, :string)
    field(:country, :string)
    field(:start_date, :date)

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
      :twitter,
      :country,
      :start_date
    ])
    |> validate_required([:name, :external_id])
  end
end
