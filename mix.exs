defmodule Skaro.MixProject do
  use Mix.Project

  def project do
    [
      app: :skaro,
      version: "0.0.1",
      elixir: "~> 1.5",
      elixirc_options: [warnings_as_errors: true],
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      releases: releases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Skaro.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # phoenix and ecto
      {:phoenix, "~> 1.5.0"},
      {:phoenix_pubsub, "~> 2.0"},
      {:phoenix_ecto, "~> 4.0"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.1"},
      {:plug_cowboy, "~> 2.2"},

      # auth
      {:bcrypt_elixir, "~> 2.0"},
      {:guardian, "~> 2.0"},

      # utils
      {:scrivener_ecto, "~> 2.0"},
      {:secure_random, "~> 0.5"},
      {:cors_plug, "~> 2.0"},

      # http client
      {:httpoison, "~> 1.4"},
      {:hackney, "~> 1.16"},

      # caching
      {:con_cache, "~> 0.14.0"},

      # error handling
      {:sentry, "~> 8.0"},

      # countries info
      {:countries, "~> 1.6"},

      # html parsing
      {:floki, "~> 0.26"},

      # lint
      {:credo, "~> 1.4.0", only: [:dev, :test], runtime: false},

      # testing
      {:timex, "~> 3.1"},
      {:tzdata, "~> 1.0.1"},
      {:ex_machina, "~> 2.2"},
      {:mox, "~> 0.4", only: :test},
      {:bypass, "~> 1.0", only: :test}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end

  defp releases() do
    [
      skaro: [
        include_executables_for: [:unix]
      ]
    ]
  end
end
