defmodule Skaro.Repo do
  use Ecto.Repo,
    otp_app: :skaro,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
end
