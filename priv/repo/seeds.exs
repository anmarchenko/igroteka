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
