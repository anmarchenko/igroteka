defmodule SkaroWeb.AvailablePlatformView do
  use SkaroWeb, :view

  def render("index.json", %{available_platforms: available_platforms}) do
    render_many(
      available_platforms,
      SkaroWeb.AvailablePlatformView,
      "show.json"
    )
  end

  def render("show.json", %{available_platform: available_platform}) do
    %{
      id: available_platform.platform_id,
      name: available_platform.platform_name
    }
  end
end
