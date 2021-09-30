defmodule Skaro.Accounts.Users do
  @moduledoc """
    CRUD actions concerning users
  """

  alias Skaro.Accounts.User
  alias Skaro.Repo

  def get!(id), do: Repo.get!(User, id)

  def get_by_email(nil), do: nil
  def get_by_email(email), do: Repo.get_by(User, email: email)

  def add(user_params) do
    %User{}
    |> User.changeset(user_params)
    |> Repo.insert()
  end

  def update_profile(user, user_params) do
    user
    |> User.update_profile(user_params)
    |> Repo.update()
  end

  def update_password(user, user_params) do
    user
    |> User.update_password(user_params)
    |> Repo.update()
  end

  def update_stats(user, stats_map) do
    user
    |> User.update_stats(%{stats: stats_map})
    |> Repo.update()
  end
end
