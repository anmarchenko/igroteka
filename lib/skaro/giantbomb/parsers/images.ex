defmodule Skaro.Giantbomb.ImagesParser do
  @moduledoc """
  Set of functions for working with Giantbomb's images data.
  """
  alias Skaro.Core.Image

  def parse_many(nil), do: []
  def parse_many(images_json), do: Enum.map(images_json, &parse/1)

  def parse(json) do
    %Image{
      id: json["id"],
      big_url: json["medium_url"],
      thumb_url: json["thumb_url"]
    }
  end
end
