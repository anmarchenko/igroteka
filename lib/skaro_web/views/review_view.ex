defmodule SkaroWeb.ReviewView do
  use SkaroWeb, :view

  def render("index.json", %{ratings: ratings}) do
    render_many(
      ratings,
      SkaroWeb.RatingView,
      "show.json"
    )
  end

  def render("show.json", %{rating: nil}), do: nil

  def render("show.json", %{rating: rating}) do
    %{
      id: rating.id,
      external_id: rating.external_id,
      percent_recommended: rating.percent_recommended,
      score: rating.score,
      num_reviews: rating.num_reviews,
      tier: rating.tier,
      summary: rating.summary,
      reviews: rating.reviews,
      points: rating.points
    }
  end
end
