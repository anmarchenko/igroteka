defmodule SkaroWeb.ExternalLinkView do
  use SkaroWeb, :view

  def render("index.json", %{external_links: external_links}) do
    render_many(
      external_links,
      SkaroWeb.ExternalLinkView,
      "show_minimal.json"
    )
  end

  def render("show_minimal.json", %{external_link: external_link}) do
    %{
      url: external_link.url,
      category: external_link.category
    }
  end
end
