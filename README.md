# Igroteka

This is the backend API for my gaming backlog app. I use it on a daily basis to keep track of video games I played/want to play/playing now. It uses [IGDB](https://www.igdb.com), [howlongtobeat.com](https://howlongtobeat.com) and [opencritic.com](https://opencritic.com) as data sources. You can read more about this project on my [personal website](https://www.amarchenko.de/igroteka/).

## Prerequisites

- [twitch API client id](https://dev.twitch.tv) for [IGDB API](https://api-docs.igdb.com/#getting-started)
- [Opencritic API key](https://rapidapi.com/opencritic-opencritic-default/api/opencritic-api)
- [elixir](https://elixir-lang.org)
- [postgres](https://www.postgresql.org)

## Run locally

Add `config/dev.secret.exs` file with the following contents:

```elixir
import Config

config :skaro, :igdb,
  client_id: "your_twitch_client_id",
  client_secret: "your_twitch_client_secret"

config :skaro, :opencritic, api_key: "your_opencritic_rapidapi_key"

config :skaro, Skaro.Repo,
  username: "your_postgres_user",
  password: "your_postgres_user_password",
```

Run the following commands to setup dependencies and create the database:

```bash
mix deps.get
mix ecto.setup
```

Run server:

```bash
mix phx.server
```

Verify that it is running by navigating to `http://localhost:4000` in your browser: if you see message "Welcome to skaro" then it's running.

After that you can setup and run [frontend app](https://github.com/anmarchenko/igroteka_fe). To use it navigate to `http://localhost:3000` and login with `admin@skaro.com/12345678`. Have fun testing the app!

## Run tests

```bash
mix test
```

## Lint

```bash
mix credo --strict
```

## Deployment

I run the app on [fly.io](https://fly.io). See the Fly.io documentation on running an Elixir application [here](https://fly.io/docs/elixir/getting-started/). The release configuration is in the [fly.toml](https://github.com/altmer/igroteka/blob/master/fly.toml).

TLDR: perform first deploy by running `fly launch` and subsequent deploys by running `fly deploy`.

## CI

This repository uses [GitHub Actions](https://github.com/features/actions) to deploy from `master` branch. The [main.yml](https://github.com/altmer/igroteka/blob/master/.github/workflows/main.yml) file defines the single workflow (for now) - fly.io deployment.

## Contexts

Phoenix contexts are used to model different domains that exist in this app.

### [Accounts](https://github.com/altmer/igroteka/blob/master/lib/skaro/accounts)

Authorization and user management.

Models:

- [User](https://github.com/altmer/igroteka/blob/master/lib/skaro/accounts/user.ex)

WIP

## API

This app provides REST-like API for a frontend application.
The following endpoints are provided:

### [SessionController](https://github.com/altmer/igroteka/blob/master/lib/skaro_web/controllers/session_controller.ex)

`POST /sessions` - creates session from email and password provided in body; returns JWT token.

### [UserController](https://github.com/altmer/igroteka/blob/master/lib/skaro_web/controllers/user_controller.ex)

`GET /current_user` - returns user info based on authentication header
