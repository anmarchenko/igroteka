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

TODO: move this to hexdocs.

Phoenix contexts are used to model different domains that exist in this app.

### [Accounts](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/accounts)

Authentication and user management.

Models:

- [User](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/accounts/user.ex) - **root aggregate** of this context, represents an application's user.

Function modules:

- [Users](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/accounts/users.ex) - CRUD actions to manage users.
- [Sessions](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/accounts/sessions.ex) - authentication code.

### [Core](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/core)

In Igroteka "Core" means "everything related to Game that is our core domain".

Models:

- [Game](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/core/game.ex) - **root aggregate**, represents a video game.
- [Company](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/core/company.ex) - represents a gamedev company (might be developer or publisher or both).
- [Platform](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/core/platform.ex) - platform where the game was released at some point in time (for example PlayStation 2 or NES).
- [Genre](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/core/genre.ex) - genre(s) that game belongs to (Action, RPG, etc).
- [Theme](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/core/theme.ex) - theme of the game.
- [Image](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/core/image.ex) - screenshot or poster for the game.
- [Video](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/core/video.ex) - video about this game on external resource (YouTube).
- [Franchise](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/core/franchise.ex) - franchise the game belongs to (eg. Zelda, Mario, God of War).
- [ExternalLink](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/core/external_link.ex) - link to some external resource (for example official website, twitter account).

Function modules:

- [Core](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/core/core.ex) - functions that find and return games using IGDB services.

### [Backlog](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/backlog)

This context deals with user's backlog - all the games that user wants to play or played in the past or playing right now. Backlog context revolves around the concept of "Entry" that represents a single game in user's backlog.

The most important attribute of Entry is **status** which can be one of the following:

- wishlist - games that user would like to buy
- backlog - games that user owns but did not play yet
- playing - games that user plays right now
- beaten - games that user played and considers to be *"done"*

Models:

- [Entry](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/backlog/entry.ex) - **root aggregate**, represents a single game in user's backlog.
- [AvailablePlatform](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/backlog/available_platform.ex) - an additional model that represents a platform where the game from the given backlog entry was released. This model exists because we need to provide a way for the user to select on which platform they are going to play this game.

Function modules:

- [Entries](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/backlog/entries.ex) - CRUD operations for Backlog context.

### [Playthrough](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/playthrough)

Playthrough context deals with data on what would it take to beat the game.

Models:

- [PlaythroughTime](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/playthrough/playthrough_time.ex) - connected to Game, represents hours one needs to beat the game in one of the playstyles (Main Quest / Main + Side Quests / Completionist).

Interfaces:

- [Remote](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/playthrough/remote.ex) - defines behaviour for any service that fetches playthrough data from external provider.

Function modules:

- [Playthrough](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/playthrough/playthrough.ex) - fetches from remote and stores playthrough data.

### [Reviews](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/reviews)

Reviews context works with critics scores and reviews for games.

Models:

- [Rating](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/reviews/rating.ex) - represents median critics score and samples of critics reviews.

Interfaces:

- [Remote](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/reviews/remote.ex) - defines behaviour for services that fetch reviews from external provider.

Function modules:

- [Reviews](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/reviews/reviews.ex) - fetches from remote and stores scores and reviews data.

### [IGDB](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/igdb)

This context encapsulates code that talks to IGDB API. NOTE: Not a domain context as it doesn't have any models.

Function modules:

- [IGDB](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/igdb/igdb.ex) - calls IGDB API and parses the JSON response to produce Core models.
- [Token](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/igdb/token.ex) - fetches API token from Twitch.

### [Howlongtobeat](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/howlongtobeat)

This context has functions that scrape and parse howlongtobeat.com pages. NOTE: Not a domain context as it doesn't have any models.

Function modules:

- [Howlongtobeat](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/howlongtobeat/howlongtobeat.ex) - context facade, implements Remote interface from Playthrough context.
- [Client](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/howlongtobeat/client.ex) - retrieves and parses information from <https://howlongtobeat.com>.

### [Opencritic](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/opencritic/opencritic.ex)

This context provides a way to work with Opencritic API. NOTE: Not a domain context as it doesn't have any models.

Function models:

- [Opencritic](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/opencritic/opencritic.ex) - context facade, implements Remote interface from Reviews context.
- [Client](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/opencritic/client.ex) - calls Opencritic API and parses the response.
- [Mapper](https://github.com/anmarchenko/igroteka/blob/master/lib/skaro/opencritic/mapper.ex) - provides transformations for Opencritic data.

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
