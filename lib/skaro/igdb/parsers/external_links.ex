defmodule Skaro.IGDB.Parsers.ExternalLinks do
  @moduledoc """
  Parses IGDB json to ExternalLink struct
  """
  alias Skaro.Core.ExternalLink

  def parse_basic(nil), do: []
  def parse_basic(json) when is_list(json), do: Enum.map(json, &parse_basic/1)

  def parse_basic(website) do
    %ExternalLink{
      url: website["url"],
      category: match_category(website["category"]),
      external_id: website["id"],
      external_category_id: website["category"]
    }
  end

  def match_category(1), do: "official"
  def match_category(2), do: "wikia"
  def match_category(3), do: "wikipedia"
  def match_category(4), do: "facebook"
  def match_category(5), do: "twitter"
  def match_category(6), do: "twitch"
  def match_category(8), do: "instagram"
  def match_category(9), do: "youtube"
  def match_category(10), do: "iphone"
  def match_category(11), do: "ipad"
  def match_category(12), do: "android"
  def match_category(13), do: "steam"
  def match_category(14), do: "reddit"
  def match_category(15), do: "discord"
  def match_category(16), do: "google_plus"
  def match_category(17), do: "tumblr"
  def match_category(18), do: "linkedin"
  def match_category(19), do: "pinterest"
  def match_category(20), do: "soundcloud"
  def match_category(_), do: "general"
end
