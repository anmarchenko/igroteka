defmodule SkaroWeb.GameView do
  use SkaroWeb, :view

  alias SkaroWeb.{
    CompanyView,
    FranchiseView,
    GenreView,
    ImageView,
    PlatformView,
    ThemeView
  }

  def render("index.json", %{games: games}) do
    render_many(
      games,
      SkaroWeb.GameView,
      "game_short.json"
    )
  end

  def render("game_short.json", %{game: game}) do
    minimal_fields(game)
  end

  def render("show.json", %{game: game}) do
    game
    |> minimal_fields
    |> Map.merge(%{
      developers:
        CompanyView.render(
          "index.json",
          companies: game.developers
        ),
      publishers:
        CompanyView.render(
          "index.json",
          companies: game.publishers
        ),
      franchises:
        FranchiseView.render(
          "index.json",
          franchises: game.franchises
        ),
      genres: GenreView.render("index.json", genres: game.genres),
      themes: ThemeView.render("index.json", themes: game.themes)
    })
  end

  defp minimal_fields(game) do
    %{
      id: game.id,
      name: game.name,
      short_description: game.short_description,
      release_date: game.release_date,
      poster: ImageView.render("show.json", image: game.cover),
      platforms: PlatformView.render("index.json", platforms: game.platforms)
    }
  end
end
