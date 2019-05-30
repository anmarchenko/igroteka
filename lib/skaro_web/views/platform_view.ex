defmodule SkaroWeb.PlatformView do
  use SkaroWeb, :view

  def render("index.json", %{platforms: platforms}) do
    render_many(
      platforms,
      SkaroWeb.PlatformView,
      "platforms_short.json"
    )
  end

  def render("platforms_short.json", %{platform: platform}) do
    %{
      id: platform.id,
      name: platform.name
    }
  end
end
