defmodule Skaro.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: Skaro.Repo

  alias Skaro.Accounts.User
  alias Skaro.Backlog.{AvailablePlatform, Entry}

  alias Skaro.Core.{
    Company,
    ExternalLink,
    Franchise,
    Game,
    Genre,
    Image,
    Platform,
    Theme,
    Video
  }

  alias Skaro.Playthrough.PlaythroughTime
  alias Skaro.Reviews.Rating

  def user_factory do
    number = :rand.uniform(10_000)

    %User{
      name: "Max Mustermann",
      email: "max.mustermann#{number}@hmstr.rocks",
      encrypted_password: Bcrypt.hash_pwd_salt("12345678")
    }
  end

  def image_factory do
    id = :rand.uniform(10_000)

    %Image{
      id: id,
      big_url: "http://images.com/#{id}/big",
      thumb_url: "http://images.com/#{id}/thumb"
    }
  end

  def platform_factory do
    id = :rand.uniform(10_000)

    %Platform{
      id: id,
      external_id: to_string(id),
      name: "Platform #{id}"
    }
  end

  def company_factory do
    id = :rand.uniform(10_000)

    %Company{
      id: id,
      external_id: to_string(id),
      name: "Company #{id}",
      external_url: "https://company#{id}.com",
      country: "US",
      logo: build(:image)
    }
  end

  def genre_factory do
    id = :rand.uniform(10_000)

    %Genre{
      id: id,
      external_id: to_string(id),
      name: "Genre #{id}"
    }
  end

  def theme_factory do
    id = :rand.uniform(10_000)

    %Theme{
      id: id,
      external_id: to_string(id),
      name: "Theme #{id}"
    }
  end

  def franchise_factory do
    id = :rand.uniform(10_000)

    %Franchise{
      id: id,
      external_id: to_string(id),
      name: "Franchise #{id}"
    }
  end

  def external_link_factory do
    id = :rand.uniform(10_000)

    %ExternalLink{
      url: "https://wikipedia.org/game#{id}",
      category: "wikipedia"
    }
  end

  def game_factory do
    id = :rand.uniform(10_000)

    %Game{
      id: id,
      external_id: to_string(id),
      external_url: "https://igdb.com/games/#{id}",
      name: "Game #{id}",
      short_description: "Some long text",
      release_date: "1996-12-12 00:00:00",
      cover: build(:image),
      rating: 85.2,
      ratings_count: 10,
      platforms: [build(:platform)],
      developers: [build(:company)],
      publishers: [build(:company)],
      franchises: [build(:franchise)],
      genres: [build(:genre)],
      themes: [build(:theme)],
      external_links: [build(:external_link)],
      videos: []
    }
  end

  def available_platform_factory do
    id = :rand.uniform(10_000)

    %AvailablePlatform{
      platform_id: id,
      platform_name: "Platform #{id}"
    }
  end

  def video_factory do
    id = :rand.uniform(10_000)

    %Video{
      id: id,
      name: "video #{id}",
      video_id: id
    }
  end

  def backlog_entry_factory do
    id = :rand.uniform(100_000)

    %Entry{
      game_id: id,
      game_name: "Game #{id}",
      game_release_date: ~D[2016-12-31],
      finished_at: ~D[2018-10-02],
      poster_thumb_url: "http://posters/#{id}/poster",
      status: "wishlist",
      note: "Generic note",
      countries: ["JP"],
      available_platforms: build_list(2, :available_platform),
      user: build(:user)
    }
  end

  def playthrough_time_factory do
    id = :rand.uniform(100_000)
    entry_id = :rand.uniform(100_000)

    %PlaythroughTime{
      game_id: id,
      game_name: "Game #{id}",
      external_id: to_string(entry_id),
      external_url: "https://howlongtobeat.com/game?id=#{id}",
      main: :rand.uniform(30) * 60,
      main_extra: :rand.uniform(60) * 60,
      completionist: :rand.uniform(100) * 60
    }
  end

  def rating_factory do
    id = :rand.uniform(100_000)
    entry_id = :rand.uniform(100_000)

    %Rating{
      game_id: id,
      game_name: "Game #{id}",
      external_id: to_string(entry_id),
      percent_recommended: :rand.uniform(100) / 100.0,
      score: :rand.uniform(100) / 100.0,
      num_reviews: :rand.uniform(200),
      tier: "Strong",
      summary: "this is game #{id}",
      reviews: [
        %{
          external_url: "http://www.ign.com/articles/watch-dogs-legion-review?watch",
          name: "IGN",
          score: 80,
          snippet: "Watch Dogs: Legion's bold use of roguelike mechanics in an open-world action"
        },
        %{
          external_url:
            "https://www.eurogamer.net/articles/2020-11-03-watch-dogs-legion-review-a-bleak-and-buggy-retread-of-ubisofts-formula",
          name: "Eurogamer",
          score: 75,
          snippet:
            "Legion's near-future London is almost too close for comfort, though the game it hosts is a characterless slog."
        }
      ],
      points: [
        %{
          description:
            "The squad formed throughout the game provide a fun twist on the typical Open World formula",
          state: "pro",
          title: "Play As Anyone"
        },
        %{
          description:
            "Many critics noted that missions begin to feel too same-y as you get deeper into the game",
          state: "con",
          title: "Repetitive Missions"
        }
      ]
    }
  end
end
