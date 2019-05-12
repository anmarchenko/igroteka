defmodule SkaroWeb.UserViewTest do
  @moduledoc false
  use SkaroWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View
  # imports factories
  import Skaro.Factory

  # show.json
  test "renders user information in json" do
    user = insert(:user, name: "John Doe")
    expected_color = "user-color-#{rem(user.id, 4)}"
    json = render(SkaroWeb.UserView, "show.json", %{user: user})
    assert json[:id] == user.id
    assert json[:name] == user.name
    assert json[:color] == expected_color
    assert json[:initials] == "JD"
  end

  # test initials
  test "capitalizes initials" do
    user = insert(:user, name: "kurt maison")
    assert render(SkaroWeb.UserView, "show.json", %{user: user})[:initials] == "KM"
  end

  test "split only using spaces" do
    user = insert(:user, name: "Lokk-Franz")
    assert render(SkaroWeb.UserView, "show.json", %{user: user})[:initials] == "L"
  end

  test "takes only two first letters" do
    user = insert(:user, name: "Pedro Carlos Juan XIII Martinez Escudero Villanueva Cortes")

    assert render(SkaroWeb.UserView, "show.json", %{user: user})[:initials] == "PC"
  end
end
