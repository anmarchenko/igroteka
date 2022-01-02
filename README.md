# Skaro

This is the backend for my gaming backlog app. It is described in detail
[here on my personal website](https://amarchenko.de/igroteka).

## Tech stack

- elixir
- phoenix
- postgresql
- guardian (for authorization)
- httpoison (making http calls to external APIs)
- con_cache (ttl cache - all the external calls are heavily cached)
- sentry (errors monitoring)
- floki (HTML parser for parsing howlongtobeat website)
- mox (testing library for behaviour based testing)
- bypass (mock server for external APIs)

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
