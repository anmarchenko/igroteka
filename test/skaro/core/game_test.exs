defmodule Skaro.Core.GameTest do
  @moduledoc false
  use Skaro.DataCase

  alias Ecto.Changeset
  alias Skaro.Core.{Game, Image}

  import Skaro.Factory

  describe "changeset/1" do
    test "it validates changeset" do
      refute Game.changeset(%Game{}, %{
               name: "invalid game",
               external_url: "http://nogame.com"
             }).valid?
    end

    test "it saves game record" do
      attrs = %{
        name: "Warcraft III",
        external_id: "4324",
        external_url: "http://warcraft.com",
        short_description: "warcraft short description",
        description: "warcraft very long description",
        release_date: DateTime.from_unix!(1_025_654_400),
        rating: 93.0,
        ratings_count: 10,
        category: 1,
        status: 1,
        ttb_hastly: 38_000,
        ttb_normally: 60_000
      }

      assert {:ok, game} =
               %Game{}
               |> Game.changeset(attrs)
               |> Repo.insert()

      assert "Warcraft III" = game.name
      assert 10 = game.ratings_count
    end

    test "it saves game record together with new associations" do
      attrs = %{
        name: "Warcraft III",
        external_id: "4324",
        cover: %{
          big_url: "http://server/img/big.png",
          thumb_url: "http://server/img/thumb.png"
        },
        external_links: [
          %{
            url: "http://server1",
            external_category_id: "1",
            category: "official"
          },
          %{
            url: "http://server2",
            external_category_id: "2",
            category: "wikia"
          }
        ]
      }

      assert {:ok, game} =
               %Game{}
               |> Game.changeset(attrs)
               |> Repo.insert()

      assert %Image{
               big_url: "http://server/img/big.png",
               thumb_url: "http://server/img/thumb.png"
             } = Repo.one(Ecto.assoc(game, :cover))

      assert 2 = game |> Ecto.assoc(:external_links) |> Repo.all() |> Enum.count()
    end

    test "it updates associations" do
      umbrella = insert(:company, %{name: "Umbrella", external_id: "u12"})
      blizzard = insert(:company, %{name: "Blizzad", external_id: "b3"})

      game = insert(:game)
      assert 1 == game |> Ecto.assoc(:developers) |> Repo.all() |> Enum.count()

      {:ok, _} =
        game
        |> Game.changeset(%{})
        |> Changeset.put_assoc(:developers, [umbrella, blizzard])
        |> Repo.update()

      developers = game |> Ecto.assoc(:developers) |> Repo.all()

      assert 2 = developers |> Enum.count()

      assert ["Blizzad", "Umbrella"] ==
               developers |> Enum.map(fn item -> item.name end) |> Enum.sort()
    end
  end
end
