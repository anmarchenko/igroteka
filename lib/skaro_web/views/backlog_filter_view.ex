defmodule SkaroWeb.BacklogFilterView do
  use SkaroWeb, :view

  def render("index.json", %{platforms: platforms, years: years}) do
    %{
      years: years,
      platforms:
        Enum.map(platforms, fn pl ->
          %{
            id: pl.platform_id,
            name: pl.platform_name
          }
        end)
    }
  end
end
