defmodule SkaroWeb.ErrorView do
  use SkaroWeb, :view

  def render("forbidden.json", _assigns) do
    %{error: "forbidden"}
  end

  def render("external_error.json", _assigns) do
    %{error: "external call failed"}
  end

  def render("404.html", _assigns) do
    "Page not found"
  end

  def render("500.html", _assigns) do
    "Internal server error"
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render("500.html", assigns)
  end
end
