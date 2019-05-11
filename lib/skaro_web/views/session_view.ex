defmodule SkaroWeb.SessionView do
  use SkaroWeb, :view

  alias SkaroWeb.UserView

  def render("show.json", %{jwt: jwt, user: user}) do
    %{
      jwt: jwt,
      user: UserView.render("user_badge.json", user: user)
    }
  end

  def render("error.json", _) do
    %{errors: %{error: "Invalid email or password"}}
  end

  def render("delete.json", _) do
    %{ok: true}
  end

  def render("forbidden.json", %{error: error}) do
    %{error: error}
  end
end
