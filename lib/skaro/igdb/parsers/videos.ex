defmodule Skaro.IGDB.Parsers.Videos do
  @moduledoc """
  Parses IGDB json to Video struct
  """
  alias Skaro.Core.Video

  def parse_basic(nil), do: []
  def parse_basic(json) when is_list(json), do: Enum.map(json, &parse_basic/1)

  def parse_basic(video) do
    %Video{
      id: video["id"],
      name: video["name"],
      video_id: video["video_id"]
    }
  end
end
