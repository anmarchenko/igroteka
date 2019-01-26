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
      supervisor(ConCache, [
        [
          ttl_check: :timer.minutes(30),
          ttl: :timer.hours(6)
        ],
        [name: :external_api_cache]
      ])
      # Starts a worker by calling: Skaro.Worker.start_link(arg)
      # {Skaro.Worker, arg},
    ]

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
