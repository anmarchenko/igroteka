import Config

if config_env() == :prod do
  secret_key_base = System.fetch_env!("SECRET_KEY_BASE")
  app_name = System.fetch_env!("FLY_APP_NAME")

  config :skaro, Skaro.Guardian, secret_key: secret_key_base

  config :skaro, SkaroWeb.Endpoint,
    server: true,
    url: [host: "#{app_name}.fly.dev", port: 80],
    http: [
      # Enable IPv6 and bind on all interfaces.
      # Set it to  {0, 0, 0, 0, 0, 0, 0, 1} for local network only access.
      # See the documentation on https://hexdocs.pm/plug_cowboy/Plug.Cowboy.html
      # for details about using IPv6 vs IPv4 and loopback vs public addresses.
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: 4000
    ],
    secret_key_base: secret_key_base

  config :skaro, Skaro.Repo,
    url: System.fetch_env!("DATABASE_URL"),
    socket_options: [:inet6],
    pool_size: 10

  config :skaro, :igdb,
    client_id: System.fetch_env!("IGDB_CLIENT_ID"),
    client_secret: System.fetch_env!("IGDB_CLIENT_SECRET")

  config :skaro, :opencritic, api_key: System.fetch_env!("OPENCRITIC_API_KEY")

  config :skaro, SkaroWeb.Telemetry,
    report_metrics: true,
    periodic_measurements_enabled: true

  config :opentelemetry_exporter,
    otlp_protocol: :http_protobuf,
    otlp_endpoint: "http://ddagent.internal:4318"

  config :opentelemetry, :resource, service: %{name: "igroteka"}
end
