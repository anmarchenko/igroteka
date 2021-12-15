import Config

if config_env() == :prod do
  config :skaro, Skaro.Guardian, secret_key: System.fetch_env!("SECRET_KEY_BASE")

  config :skaro, SkaroWeb.Endpoint,
    http: [:inet6, port: System.fetch_env!("PORT")],
    url: [host: System.fetch_env!("HOST"), port: 80]

  config :sentry,
    dsn: System.fetch_env!("SENTRY_DSN")

  config :skaro, Skaro.Repo,
    username: System.fetch_env!("POSTGRES_USER"),
    password: System.fetch_env!("POSTGRES_PASSWORD"),
    hostname: System.fetch_env!("POSTGRES_HOST")

  config :skaro, :igdb,
    client_id: System.fetch_env!("IGDB_CLIENT_ID"),
    client_secret: System.fetch_env!("IGDB_CLIENT_SECRET")
end
