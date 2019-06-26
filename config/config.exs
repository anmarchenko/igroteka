# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :skaro,
  ecto_repos: [Skaro.Repo]

# Configures the endpoint
config :skaro, SkaroWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GUaNDJBx7OaJkXDhaloxaN2uqjbrembYanto5pxyKIx3c7XhHPIpniqCINeFbIsh",
  render_errors: [view: SkaroWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Skaro.PubSub, adapter: Phoenix.PubSub.PG2]

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
  secret_key: "${SECRET_KEY_BASE}",
  token_module: Guardian.Token.Jwt

# Games API
config :skaro, :games_remote, Skaro.Giantbomb

config :skaro, :giantbomb,
  api_key: "${GIANTBOMB_API_KEY}",
  base_url: "https://www.giantbomb.com/api"

config :skaro, :igdb, base_url: "https://api-v3.igdb.com", api_key: "${IGDB_API_KEY}"

# Errors reporting
config :sentry,
  filter: Skaro.SentryEventFilter,
  environment_name: :dev,
  included_environments: [:prod]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
