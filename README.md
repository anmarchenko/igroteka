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

I run the app on [fly.io](https://fly.io). See the Fly.io documentation on running an Elixir application [here](https://fly.io/docs/elixir/getting-started/). The release configuration is in the [fly.toml](https://github.com/anmarchenko/igroteka/blob/master/fly.toml).

TLDR: perform first deploy by running `fly launch` and subsequent deploys by running `fly deploy`.

## CI

This repository uses [GitHub Actions](https://github.com/features/actions) to deploy from `master` branch. The [main.yml](https://github.com/anmarchenko/igroteka/blob/master/.github/workflows/main.yml) file defines the single workflow (for now) - fly.io deployment.

## How do we model gaming backlog

Phoenix contexts are used to model different domains that exist in this app.

### [Accounts](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/accounts)

Authorization and user management.

Models:

- [User](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/accounts/user.ex)

Function modules:

- Users
- Sessions

### Core

### IGDB

### Backlog

### Playthrough

### Howlongtobeat

### Reviews

### Opencritic

## API

This app provides REST-like API for a frontend application.
The following endpoints are provided:

### [SessionController](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro_web/controllers/session_controller.ex)

`POST /sessions` - creates session from email and password provided in body; returns JWT token.

### [UserController](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro_web/controllers/user_controller.ex)

`GET /current_user` - returns user info based on authentication header

`GET /users/{id}` - returns user info by ID

`PUT /users/{id}` - updates user's info

`PUT /users/{id}/update_password` - changes user's password

### [GameController](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro_web/controllers/game_controller.ex)

`GET /games` - filters and returns a list of games from IGDB (possible filters are: by developer, by publisher, by search term, new games, top games overall, top games by year)

`GET /games/{id}` - returns game's info from IGDB by game ID

### [BacklogEntryController](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro_web/controllers/backlog_entry_controller.ex)

This resource manages backlog entries aka games that are in your backlog.

`GET /backlog_entries` - filters backlog entries for current user

`GET /backlog_entries/{id}` - returns backlog entry

`POST /backlog_entries` - adds the game to the backlog

`PUT /backlog_entries/{id}` - updates backlog entry

`DELETE /backlog_entries/{id}` - removes the game from the user's backlog

### [BacklogFilterController](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro_web/controllers/backlog_filter_controller.ex)

`GET /backlog_filters` - returns filters view model for user's backlog (available release years and platforms for example)

### [ScreenshotController](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro_web/controllers/screenshot_controller.ex)

`GET /screenshots` - returns a list of screenshots for a given game

### [PlaythroughTimeController](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro_web/controllers/playthrough_time_controller.ex)

`GET /playthrough_times/{game_id}` - returns info on how long is the game to play

### [ReviewController](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro_web/controllers/review_controller.ex)

`GET /reviews/{game_id}` - returns critics rating and reviews for the game

### [CompanyController](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro_web/controllers/company_controller.ex)

`GET /companies/{id}` - returns information about game development company (developer or publisher)
