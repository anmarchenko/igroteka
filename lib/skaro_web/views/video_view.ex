defmodule SkaroWeb.VideoView do
  use SkaroWeb, :view

  def render("index.json", %{videos: videos}) do
    render_many(
      videos,
      SkaroWeb.VideoView,
      "show.json"
    )
  end

  def render("show.json", %{video: video}) do
    %{
      id: video.id,
      name: video.name,
      video_id: video.video_id
    }
  end
end
