defmodule Skaro.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias Skaro.Repo
  alias SkaroWeb.Endpoint

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Repo,
      # Start the endpoint when the application starts
      Endpoint,
      # Start the Telemetry supervisor
      SkaroWeb.Telemetry,
      # pubsub
      {Phoenix.PubSub, [name: Skaro.PubSub, adapter: Phoenix.PubSub.PG2]},
      # cache
      {ConCache,
       [
         name: :external_api_cache,
         ttl_check_interval: :timer.minutes(30),
         global_ttl: :timer.hours(6)
       ]}
    ]

    # required for OTLP exporter to use IPv6 addresses
    :httpc.set_option(:ipfamily, :inet6fb4)

    :ok = OpentelemetryPhoenix.setup()

    :ok =
      Skaro.Repo.config()
      |> Keyword.fetch!(:telemetry_prefix)
      |> OpentelemetryEcto.setup(db_statement: :enabled)

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Skaro.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Endpoint.config_change(changed, removed)
    :ok
  end
end
