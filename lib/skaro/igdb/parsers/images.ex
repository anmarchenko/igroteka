defmodule Skaro.IGDB.Parsers.Images do
  @moduledoc """
  Parses IGDB json to Image struct
  """
  alias Skaro.Core.Image

  def parse_cover(json) do
    %Image{
      thumb_url: image_url(:cover, :small, json["image_id"]),
      big_url: image_url(:cover, :big, json["image_id"])
    }
  end

  defp image_url(:cover, :small, id),
    do: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/#{id}.jpg"

  defp image_url(:cover, :big, id),
    do: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/#{id}.jpg"
end
