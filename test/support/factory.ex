defmodule Skaro.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: Skaro.Repo

  alias Skaro.Accounts.User
  alias Skaro.Backlog.{AvailablePlatform, Entry}
  # alias Skaro.Gaming.Data.{Company, Franchise, Game, Genre, Image, Platform, Theme}

  def user_factory do
    number = :rand.uniform(10_000)

    %User{
      name: "Max Mustermann",
      email: "max.mustermann#{number}@hmstr.rocks",
      encrypted_password: Bcrypt.hash_pwd_salt("12345678")
    }
  end

  # def image_factory do
  #   id = :rand.uniform(10000)

  #   %Image{
  #     id: id,
  #     big_url: Faker.Internet.image_url(),
  #     thumb_url: Faker.Internet.image_url()
  #   }
  # end

  # def platform_factory do
  #   id = :rand.uniform(10000)

  #   %Platform{
  #     id: id,
  #     external_id: to_string(id),
  #     name: Faker.Superhero.name()
  #   }
  # end

  # def company_factory do
  #   id = :rand.uniform(10000)

  #   %Company{
  #     id: id,
  #     external_id: to_string(id),
  #     name: Faker.Company.name()
  #   }
  # end

  # def genre_factory do
  #   id = :rand.uniform(10000)

  #   %Genre{
  #     id: id,
  #     external_id: to_string(id),
  #     name: Faker.Company.name()
  #   }
  # end

  # def theme_factory do
  #   id = :rand.uniform(10000)

  #   %Theme{
  #     id: id,
  #     external_id: to_string(id),
  #     name: Faker.Company.name()
  #   }
  # end

  # def franchise_factory do
  #   id = :rand.uniform(10000)

  #   %Franchise{
  #     id: id,
  #     external_id: to_string(id),
  #     name: Faker.Company.name()
  #   }
  # end

  # def game_factory do
  #   id = :rand.uniform(10000)

  #   %Game{
  #     id: id,
  #     external_id: to_string(id),
  #     name: Faker.Pokemon.name(),
  #     short_description: Faker.Lorem.Shakespeare.as_you_like_it(),
  #     release_date: "1996-12-12 00:00:00",
  #     cover: build(:image),
  #     platforms: [build(:platform)],
  #     developers: [build(:company)],
  #     publishers: [build(:company)],
  #     franchises: [build(:franchise)],
  #     genres: [build(:genre)],
  #     themes: [build(:theme)]
  #   }
  # end

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
