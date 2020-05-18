defmodule SkaroWeb.ScreenshotView do
  use SkaroWeb, :view

  def render("index.json", %{screenshots: screenshots}) do
    render_many(
      screenshots,
      SkaroWeb.ScreenshotView,
      "show.json"
    )
  end

  def render("show.json", %{screenshot: screenshot}) do
    %{
      original: screenshot.big_url,
      thumbnail: screenshot.thumb_url
    }
  end
end
