defmodule SkaroWeb.CompanyView do
  use SkaroWeb, :view

  alias SkaroWeb.ImageView

  def render("index.json", %{companies: companies}) do
    render_many(
      companies,
      SkaroWeb.CompanyView,
      "show_minimal.json"
    )
  end

  def render("show.json", %{company: company}) do
    render("show_minimal.json", %{company: company})
    |> Map.merge(%{
      description: company.description,
      logo: ImageView.render("show.json", image: company.logo),
      website: company.website,
      start_date: company.start_date
    })
  end

  def render("show_minimal.json", %{company: company}) do
    %{
      id: company.id,
      name: company.name,
      country: company.country,
      external_url: company.external_url
    }
  end
end
