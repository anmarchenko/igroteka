# Skaro

This is the backend for my gaming backlog app. It is being developed in Elixir and
Phoenix Framework.

## Local development

Add `config/dev.secret.exs` file with the following contents:

```elixir
import Config

config :skaro, :igdb,
  client_id: "your_twitch_client_id",
  client_secret: "your_twitch_client_secret"
```

- Install postgres for your system
- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server`

## Tests

```bash
mix test
```

## Linter

```bash
mix credo --strict
```
