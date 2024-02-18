# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Skaro.Repo.insert!(%Skaro.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Skaro.Repo
alias Skaro.Accounts.User
alias Skaro.Backlog.Entry
alias Skaro.IGDB

[
  %{
    name: "Andrey Marchenko",
    email: "altmer@mail.test",
    password: "12345678"
  },
  %{
    name: "John Doe",
    email: "admin@skaro.com",
    password: "12345678"
  }
]
|> Enum.map(&User.changeset(%User{}, &1))
|> Enum.each(&Repo.insert!(&1))

user = Repo.get_by!(User, email: "altmer@mail.test")

# { id: 167, name: 'PlayStation 5' },
# { id: 169, name: 'Xbox Series' },
# { id: 130, name: 'Nintendo Switch' },
# { id: 390, name: 'PlayStation VR2' },

# backlog for altmer@mail.test
backlog = [
  %{
    # FF VII Rebirth
    game_id: 133_236,
    status: "wishlist",
    expectation_rating: 3,
    owned_platform_id: 167,
    owned_platform_name: "PlayStation 5",
    score: nil,
    finished_at: nil
  },
  %{
    # Prince of Persia Lost Crown
    game_id: 252_476,
    status: "wishlist",
    expectation_rating: 2,
    owned_platform_id: 130,
    owned_platform_name: "Nintendo Switch",
    score: nil,
    finished_at: nil
  },
  %{
    # Baldur's Gate 3
    game_id: 119_171,
    status: "wishlist",
    expectation_rating: 2,
    owned_platform_id: 167,
    owned_platform_name: "PlayStation 5",
    score: nil,
    finished_at: nil
  },
  %{
    # Starfield
    game_id: 96_437,
    status: "wishlist",
    expectation_rating: 1,
    owned_platform_id: 169,
    owned_platform_name: "Xbox Series",
    score: nil,
    finished_at: nil
  },
  %{
    # Cocoon
    game_id: 204_627,
    status: "wishlist",
    expectation_rating: 1,
    owned_platform_id: 130,
    owned_platform_name: "Nintendo Switch",
    score: nil,
    finished_at: nil
  },
  %{
    # Pokémon Legends: Arceus
    game_id: 144_054,
    status: "wishlist",
    expectation_rating: 1,
    owned_platform_id: 130,
    owned_platform_name: "Nintendo Switch",
    score: nil,
    finished_at: nil
  },
  %{
    # Super Smash Bros. Ultimate
    game_id: 90_101,
    status: "wishlist",
    expectation_rating: 1,
    owned_platform_id: 130,
    owned_platform_name: "Nintendo Switch",
    score: nil,
    finished_at: nil
  },
  %{
    # Super Mario Bros. Wonder
    game_id: 254_339,
    status: "backlog",
    expectation_rating: 3,
    owned_platform_id: 130,
    owned_platform_name: "Nintendo Switch",
    score: nil,
    finished_at: nil
  },
  %{
    # Marvel's Spider-Man 2
    game_id: 127_044,
    status: "backlog",
    expectation_rating: 3,
    owned_platform_id: 167,
    owned_platform_name: "PlayStation 5",
    score: nil,
    finished_at: nil
  },
  %{
    # Cyberpunk 2077: Phantom Liberty
    game_id: 215_769,
    status: "backlog",
    expectation_rating: 3,
    owned_platform_id: 169,
    owned_platform_name: "Xbox Series",
    score: nil,
    finished_at: nil
  },
  %{
    # Resident Evil Village
    game_id: 55_163,
    status: "backlog",
    expectation_rating: 2,
    owned_platform_id: 390,
    owned_platform_name: "PlayStation VR2",
    score: nil,
    finished_at: nil
  },
  %{
    # Armored Core VI: Fires of Rubicon
    game_id: 228_542,
    status: "backlog",
    expectation_rating: 2,
    owned_platform_id: 167,
    owned_platform_name: "PlayStation 5",
    score: nil,
    finished_at: nil
  },
  %{
    # Gran Turismo 7
    game_id: 101_006,
    status: "backlog",
    expectation_rating: 2,
    owned_platform_id: 167,
    owned_platform_name: "PlayStation 5",
    score: nil,
    finished_at: nil
  },
  %{
    # Kena: Bridge of Spirits
    game_id: 134_588,
    status: "backlog",
    expectation_rating: 1,
    owned_platform_id: 167,
    owned_platform_name: "PlayStation 5",
    score: nil,
    finished_at: nil
  },
  %{
    # Final Fantasy XVI
    game_id: 31_551,
    status: "playing",
    expectation_rating: 3,
    owned_platform_id: 167,
    owned_platform_name: "PlayStation 5",
    score: nil,
    finished_at: nil
  },
  %{
    # Zelda Tears of the Kingdom
    game_id: 119_388,
    status: "playing",
    expectation_rating: 3,
    owned_platform_id: 130,
    owned_platform_name: "Nintendo Switch",
    score: nil,
    finished_at: nil
  },
  %{
    # Elden Ring
    game_id: 119_133,
    status: "beaten",
    expectation_rating: 3,
    owned_platform_id: 167,
    owned_platform_name: "PlayStation 5",
    score: 5,
    finished_at: ~D[2023-09-02]
  },
  %{
    # Hitman 3
    game_id: 134_595,
    status: "beaten",
    expectation_rating: 2,
    owned_platform_id: 169,
    owned_platform_name: "Xbox Series",
    score: 4,
    finished_at: ~D[2023-06-29]
  },
  %{
    # Tunic
    game_id: 23_733,
    status: "beaten",
    expectation_rating: 1,
    owned_platform_id: 130,
    owned_platform_name: "Nintendo Switch",
    score: 2,
    finished_at: ~D[2023-05-10]
  },
  %{
    # Horizon Forbidden West
    game_id: 112_874,
    status: "beaten",
    expectation_rating: 2,
    owned_platform_id: 167,
    owned_platform_name: "PlayStation 5",
    score: 3,
    finished_at: ~D[2022-09-04]
  }
]

backlog
|> Enum.map(fn attrs ->
  {:ok, game} = IGDB.find_one(attrs.game_id)

  attrs
  |> Map.merge(%{
    game_name: game.name,
    poster_thumb_url: game.cover.thumb_url,
    game_release_date: game.release_date,
    countries: Enum.uniq(Enum.map(game.developers, & &1.country)),
    available_platforms:
      Enum.map(game.platforms, fn platform ->
        %{
          id: platform.id,
          name: platform.name
        }
      end),
    user_id: user.id
  })
end)
|> Enum.each(fn params ->
  changeset = Entry.changeset(%Entry{}, params)
  Repo.insert!(changeset)
end)
