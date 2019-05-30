defmodule SkaroWeb.ThemeView do
  use SkaroWeb, :view

  def render("index.json", %{themes: themes}) do
    render_many(
      themes,
      SkaroWeb.ThemeView,
      "show.json"
    )
  end

  def render("show.json", %{theme: theme}) do
    %{
      id: theme.id,
      name: theme.name
    }
  end
end
