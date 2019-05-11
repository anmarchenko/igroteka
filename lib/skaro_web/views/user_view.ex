defmodule SkaroWeb.UserView do
  use SkaroWeb, :view

  def render("show.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      color: color(user),
      initials: initials(user),
      bio: user.bio
    }
  end

  def render("user_badge.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      color: color(user),
      initials: initials(user)
    }
  end

  def render("error.json", _) do
  end

  defp color(user) do
    "user-color-#{rem(user.id, 4)}"
  end

  defp initials(user) do
    user.name
    |> String.split(~r{\s}, trim: true)
    |> Enum.map(&String.first(&1))
    |> Enum.take(2)
    |> Enum.join()
    |> String.upcase()
  end
end
