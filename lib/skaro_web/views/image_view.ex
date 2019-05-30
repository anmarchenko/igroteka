defmodule SkaroWeb.ImageView do
  use SkaroWeb, :view

  def render("index.json", %{images: images}) do
    render_many(
      images,
      SkaroWeb.ImageView,
      "show.json"
    )
  end

  def render("show.json", %{image: image}) do
    %{
      id: image.id,
      medium_url: image.big_url,
      thumb_url: image.thumb_url
    }
  end
end
