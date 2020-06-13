import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :skaro, SkaroWeb.Endpoint,
  http: [port: 4002],
  server: false,
  secret_key_base: "2cZ4DdZKTfTogyYTouT7TT5cuhErXG5lES5EKqPmGxAujTRyPfpxKc9HoydtYKoL_test_key"

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :skaro, Skaro.Repo,
  username: "postgres",
  password: "",
  database: "skaro_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# guardian secret key
config :skaro, Skaro.Guardian,
  secret_key: "svWE1TQ9lYke32lLUdE5jnV+EqI7nObwZ/rFYLH+s6BFRKU/prg559ADuLaohNx9_test"

config :skaro, :giantbomb, api_key: "giantbomb_api_key"
config :skaro, :igdb, api_key: "igdb_api_key"

config :skaro, :games_remote, Skaro.GamesRemoteMock
config :skaro, :playthrough_remote, Skaro.PlaythroughRemoteMock
