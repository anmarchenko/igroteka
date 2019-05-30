defmodule SkaroWeb.FranchiseView do
  use SkaroWeb, :view

  def render("index.json", %{franchises: franchises}) do
    render_many(
      franchises,
      SkaroWeb.FranchiseView,
      "show_minimal.json"
    )
  end

  def render("show_minimal.json", %{franchise: franchise}) do
    %{
      id: franchise.id,
      name: franchise.name
    }
  end
end
