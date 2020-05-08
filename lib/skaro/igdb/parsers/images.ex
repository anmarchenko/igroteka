defmodule Skaro.IGDB.Parsers.Images do
  @moduledoc """
  Parses IGDB json to Image struct
  """
  alias Skaro.Core.Image

  def parse_cover(nil) do
    %Image{
      id: -1,
      thumb_url: "https://via.placeholder.com/100x120?text=No%20cover",
      big_url: "https://via.placeholder.com/160x192?text=No%20cover"
    }
  end

  def parse_cover(json) do
    %Image{
      id: json["image_id"],
      thumb_url: image_url(:cover, :small, json["image_id"]),
      big_url: image_url(:cover, :big, json["image_id"])
    }
  end

  @spec parse_logo(nil | maybe_improper_list | map) :: Skaro.Core.Image.t()
  def parse_logo(nil) do
    %Image{
      id: -1,
      thumb_url: "https://via.placeholder.com/100x120?text=No%20cover",
      big_url: "https://via.placeholder.com/160x192?text=No%20cover"
    }
  end

  def parse_logo(json) do
    %Image{
      id: json["image_id"],
      thumb_url: image_url(:logo, :small, json["image_id"]),
      big_url: image_url(:logo, :big, json["image_id"])
    }
  end

  defp image_url(:cover, :small, id),
    do: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/#{id}.jpg"

  defp image_url(:cover, :big, id),
    do: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/#{id}.jpg"

  defp image_url(:logo, :small, id),
    do: "https://images.igdb.com/igdb/image/upload/t_thumb/#{id}.jpg"

  defp image_url(:logo, :big, id),
    do: "https://images.igdb.com/igdb/image/upload/t_logo_med_2x/#{id}.jpg"
end
