defmodule SkaroWeb.GameView do
  use SkaroWeb, :view

  alias SkaroWeb.{
    CompanyView,
    ExternalLinkView,
    FranchiseView,
    GenreView,
    ImageView,
    PlatformView,
    ThemeView,
    VideoView
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
    |> Map.merge(%{
      backlog_entries:
        Enum.map(game.backlog_entries, fn entry ->
          %{status: entry.status}
        end)
    })
  end

  def render("show.json", %{game: game}) do
    game
    |> minimal_fields
    |> Map.merge(%{
      external_url: game.external_url,
      franchises:
        FranchiseView.render(
          "index.json",
          franchises: game.franchises
        ),
      external_links:
        ExternalLinkView.render(
          "index.json",
          external_links: game.external_links
        ),
      genres: GenreView.render("index.json", genres: game.genres),
      themes: ThemeView.render("index.json", themes: game.themes),
      videos: VideoView.render("index.json", videos: game.videos)
    })
  end

  defp minimal_fields(game) do
    %{
      id: game.id,
      name: game.name,
      short_description: game.short_description,
      release_date: game.release_date,
      rating: game.rating,
      ratings_count: game.ratings_count,
      poster: ImageView.render("show.json", image: game.cover),
      platforms: PlatformView.render("index.json", platforms: game.platforms),
      developers:
        CompanyView.render(
          "index.json",
          companies: game.developers
        ),
      publishers:
        CompanyView.render(
          "index.json",
          companies: game.publishers
        )
    }
  end
end
