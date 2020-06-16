defmodule SkaroWeb.PlaythroughTimeView do
  use SkaroWeb, :view

  alias Skaro.Playthrough

  def render("index.json", %{playthrough_times: playthrough_times}) do
    render_many(
      playthrough_times,
      SkaroWeb.PlaythroughTimeView,
      "show.json"
    )
  end

  def render("show.json", %{playthrough_time: nil}), do: nil

  def render("show.json", %{playthrough_time: playthrough_time}) do
    %{
      id: playthrough_time.id,
      main: playthrough_time.main,
      main_extra: playthrough_time.main_extra,
      completionist: playthrough_time.completionist,
      external_url: playthrough_time.external_url
    }
    |> Map.merge(Playthrough.category_badge(playthrough_time))
  end
end
