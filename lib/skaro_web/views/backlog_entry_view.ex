defmodule SkaroWeb.BacklogEntryView do
  use SkaroWeb, :view

  alias SkaroWeb.{AvailablePlatformView, PlaythroughTimeView, ReviewView}

  def render("index.json", %{paginated_entries: backlog_entries}) do
    %{
      page: backlog_entries.page_number,
      total_pages: backlog_entries.total_pages,
      data:
        render_many(
          backlog_entries,
          SkaroWeb.BacklogEntryView,
          "show_index.json"
        ),
      meta: %{
        page: backlog_entries.page_number,
        total_pages: backlog_entries.total_pages,
        total_count: backlog_entries.total_entries
      }
    }
  end

  def render("show.json", %{backlog_entry: backlog_entry}) do
    %{
      id: backlog_entry.id,
      game_id: backlog_entry.game_id,
      game_name: backlog_entry.game_name,
      game_release_date: backlog_entry.game_release_date,
      poster_thumb_url: backlog_entry.poster_thumb_url,
      status: backlog_entry.status,
      owned_platform_id: backlog_entry.owned_platform_id,
      owned_platform_name: backlog_entry.owned_platform_name,
      score: backlog_entry.score,
      expectation_rating: backlog_entry.expectation_rating,
      finished_at: backlog_entry.finished_at,
      countries: backlog_entry.countries,
      available_platforms:
        AvailablePlatformView.render(
          "index.json",
          available_platforms: backlog_entry.available_platforms
        )
    }
  end

  def render("show_index.json", %{backlog_entry: backlog_entry}) do
    render("show.json", %{backlog_entry: backlog_entry})
    |> Map.merge(%{
      playthrough_time:
        PlaythroughTimeView.render("show.json", playthrough_time: backlog_entry.playthrough_time)
    })
    |> Map.merge(%{
      rating: ReviewView.render("show.json", rating: backlog_entry.rating)
    })
  end
end
