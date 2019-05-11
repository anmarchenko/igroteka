defmodule Skaro.ReleaseTasks do
  @moduledoc """
  Release tasks: create and migrate DB
  """

  require Logger

  @start_apps [
    :crypto,
    :ssl,
    :postgrex,
    :ecto,
    # If using Ecto 3.0 or higher
    :ecto_sql
  ]
  @app :skaro

  @repos Application.get_env(@app, :ecto_repos, [])

  def migrate(_argv) do
    start_services()

    run_migrations()

    stop_services()
  end

  def create_db(_argv) do
    start_services()

    run_create()

    stop_services()
  end

  defp start_services do
    IO.puts("Starting dependencies..")
    # Start apps necessary for executing migrations
    Enum.each(@start_apps, &Application.ensure_all_started/1)

    # Start the Repo(s) for app
    IO.puts("Starting repos..")

    # Switch pool_size to 2 for ecto > 3.0
    Enum.each(@repos, & &1.start_link(pool_size: 2))
  end

  defp stop_services do
    IO.puts("Success!")
    :init.stop()
  end

  defp run_migrations do
    Enum.each(@repos, &run_migrations_for/1)
  end

  defp run_migrations_for(repo) do
    app = Keyword.get(repo.config, :otp_app)
    IO.puts("Running migrations for #{app}")
    migrations_path = priv_path_for(repo, "migrations")
    Ecto.Migrator.run(repo, migrations_path, :up, all: true)
  end

  defp run_create do
    Enum.each(@repos, &run_create_for/1)
  end

  defp run_create_for(repo) do
    config = [
      username: db_config(repo, :username),
      password: db_config(repo, :password),
      hostname: db_config(repo, :hostname),
      database: db_config(repo, :database)
    ]

    IO.puts("#{inspect(config)}")

    case repo.__adapter__().storage_up(config) do
      :ok ->
        Logger.info("Database created")

      {:error, :already_up} ->
        Logger.info("Database already exists")

      {:error, reason} ->
        raise "Database creation failed (#{reason})"
    end
  end

  defp priv_path_for(repo, filename) do
    app = Keyword.get(repo.config, :otp_app)

    repo_underscore =
      repo
      |> Module.split()
      |> List.last()
      |> Macro.underscore()

    priv_dir = "#{:code.priv_dir(app)}"

    Path.join([priv_dir, repo_underscore, filename])
  end

  defp db_config(repo), do: Application.get_env(@app, repo)

  defp db_config(repo, key) do
    case repo |> db_config() |> Keyword.fetch(key) do
      {:ok, val} -> val
      :error -> nil
    end
  end
end
