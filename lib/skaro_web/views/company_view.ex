defmodule SkaroWeb.CompanyView do
  use SkaroWeb, :view

  def render("index.json", %{companies: companies}) do
    render_many(
      companies,
      SkaroWeb.CompanyView,
      "show_minimal.json"
    )
  end

  def render("show_minimal.json", %{company: company}) do
    %{
      id: company.id,
      name: company.name
    }
  end
end
