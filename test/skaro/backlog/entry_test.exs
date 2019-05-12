defmodule Skaro.EntryTest do
  @moduledoc false
  use Skaro.DataCase

  import Skaro.Factory

  alias Skaro.Backlog.Entry

  setup do
    user = insert(:user)

    {:ok, %{user: user}}
  end

  @platforms [%{platform_id: 42, platform_name: "PC"}]
  @valid_attrs %{
    game_id: 1234,
    game_name: "game name",
    status: "wishlist",
    available_platforms: @platforms
  }
  @wrong_status %{
    game_id: 1234,
    game_name: "game name",
    status: "custom",
    available_platforms: @platforms
  }
  @missing_game_name %{game_id: 1234, status: "wishlist", available_platforms: @platforms}

  describe "Entry.changeset/2" do
    test "changeset with valid attributes", %{user: user} do
      attrs = @valid_attrs |> Map.put(:user_id, user.id)
      changeset = Entry.changeset(%Entry{}, attrs)
      assert changeset.valid?
    end

    test "changeset with missing attribute", %{user: user} do
      attrs = @missing_game_name |> Map.put(:user_id, user.id)
      changeset = Entry.changeset(%Entry{}, attrs)
      refute changeset.valid?
    end

    test "changeset with wrong status", %{user: user} do
      attrs = @wrong_status |> Map.put(:user_id, user.id)
      changeset = Entry.changeset(%Entry{}, attrs)
      refute changeset.valid?
    end

    test "changeset without user_id" do
      changeset = Entry.changeset(%Entry{}, @valid_attrs)
      refute changeset.valid?
    end
  end
end
