defmodule SkaroWeb.Router do
  use SkaroWeb, :router
  use Plug.ErrorHandler
  use Sentry.Plug

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]

    plug(
      Guardian.Plug.Pipeline,
      module: Skaro.Guardian,
      error_handler: SkaroWeb.AuthErrorHandler
    )

    plug(Guardian.Plug.VerifyHeader, realm: :none)
    plug(Guardian.Plug.LoadResource, allow_blank: true)
  end

  scope "/", SkaroWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", SkaroWeb do
    pipe_through :api

    post("/sessions", SessionController, :create)

    get("/current_user", UserController, :current)
    resources("/users", UserController, only: [:show, :update])

    scope "/users" do
      put("/:id/update_password", UserController, :update_password)
    end

    # app
    resources("/games", GameController, only: [:index, :show])
    resources("/backlog_entries", BacklogEntryController)
    resources("/backlog_filters", BacklogFilterController, only: [:index])
    resources("/screenshots", ScreenshotController, only: [:index])
    resources("/playthrough_times", PlaythroughTimeController, only: [:show])
  end
end
