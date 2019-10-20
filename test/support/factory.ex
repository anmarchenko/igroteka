defmodule Skaro.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: Skaro.Repo

  alias Skaro.Accounts.User
  alias Skaro.Backlog.{AvailablePlatform, Entry}
  alias Skaro.Core.{Company, ExternalLink, Franchise, Game, Genre, Image, Platform, Theme}

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
      name: "Company #{id}"
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
      external_links: [build(:external_link)]
    }
  end

  def available_platform_factory do
    id = :rand.uniform(10_000)

    %AvailablePlatform{
      platform_id: id,
      platform_name: "Platform #{id}"
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
      available_platforms: build_list(2, :available_platform),
      user: build(:user)
    }
  end
end
