# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :skaro,
  ecto_repos: [Skaro.Repo]

# Configures the endpoint
config :skaro, SkaroWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GUaNDJBx7OaJkXDhaloxaN2uqjbrembYanto5pxyKIx3c7XhHPIpniqCINeFbIsh",
  render_errors: [view: SkaroWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: Skaro.PubSub,
  live_view: [signing_salt: "EN9gLKjW"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# authentication config
config :skaro, Skaro.Guardian,
  issuer: "Skaro",
  verify_issuer: true,
  token_module: Guardian.Token.Jwt

# API
config :skaro, :games_remote, Skaro.IGDB
config :skaro, :playthrough_remote, Skaro.Howlongtobeat
config :skaro, :reviews_remote, Skaro.Opencritic

config :skaro, :igdb,
  base_url: "https://api.igdb.com/v4",
  oauth_url: "https://id.twitch.tv/oauth2/token"

config :skaro, :howlongtobeat, base_url: "https://howlongtobeat.com"
config :skaro, :opencritic, base_url: "https://opencritic-api.p.rapidapi.com"

# metrics collecting
config :skaro, SkaroWeb.Telemetry,
  report_metrics: false,
  periodic_measurements_enabled: true

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
