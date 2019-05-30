defmodule SkaroWeb.GenreView do
  use SkaroWeb, :view

  def render("index.json", %{genres: genres}) do
    render_many(
      genres,
      SkaroWeb.GenreView,
      "show.json"
    )
  end

  def render("show.json", %{genre: genre}) do
    %{
      id: genre.id,
      name: genre.name
    }
  end
end
