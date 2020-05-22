defmodule Skaro.Core.Video do
  @moduledoc """
  Represents video about a game
  """
  use Ecto.Schema

  alias Skaro.Core.Game

  schema "videos" do
    field(:name, :string)
    field(:video_id, :string)

    belongs_to(:game, Game)

    timestamps()
  end
end
