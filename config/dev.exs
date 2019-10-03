use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with webpack to recompile .js and .css sources.
config :skaro, SkaroWeb.Endpoint,
  http: [port: 4000],
  secret_key_base: "2cZ4DdZKTfTogyYTouT7TT5cuhErXG5lES5EKqPmGxAujTRyPfpxKc9HoydtYKoL_dev_key",
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

# Watch static and templates for browser reloading.
config :skaro, SkaroWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{lib/skaro_web/views/.*(ex)$},
      ~r{lib/skaro_web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

# Configure your database
config :skaro, Skaro.Repo,
  username: "postgres",
  password: "",
  database: "skaro_dev",
  hostname: "localhost",
  pool_size: 10

# guardian secret key
config :skaro, Skaro.Guardian,
  secret_key: "svWE1TQ9lYke32lLUdE5jnV+EqI7nObwZ/rFYLH+s6BFRKU/prg559ADuLaohNx9_dev"

import_config "dev.secret.exs"
