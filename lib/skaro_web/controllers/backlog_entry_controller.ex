defmodule SkaroWeb.BacklogEntryController do
  use SkaroWeb, :controller

  alias Skaro.Backlog.Entries
  alias Skaro.Guardian.Plug, as: GuardianPlug

  action_fallback(SkaroWeb.FallbackController)

  plug(Guardian.Plug.EnsureAuthenticated)

  def index(conn, %{"filters" => filters}) do
    res =
      conn
      |> GuardianPlug.current_resource()
      |> Entries.list(filters)

    render(conn, "index.json", paginated_entries: res)
  end

  def show(conn, %{"id" => game_id}) do
    res =
      conn
      |> GuardianPlug.current_resource()
      |> Entries.get_by_game_id!(game_id)

    render(conn, "show.json", backlog_entry: res)
  end

  def show(_, _), do: {:error, :bad_request}

  def create(conn, %{
        "backlog_entry" => entry_params,
        "platforms" => platforms
      }) do
    case Entries.add(entry_params, GuardianPlug.current_resource(conn), platforms) do
      {:ok, entry} ->
        conn
        |> put_status(:created)
        |> render("show.json", backlog_entry: entry)

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def update(conn, %{"id" => game_id, "backlog_entry" => entry_params}) do
    with entry <- Entries.get_by_game_id!(GuardianPlug.current_resource(conn), game_id),
         {:ok, entry} <- Entries.update(entry, entry_params) do
      render(conn, "show.json", backlog_entry: entry)
    else
      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def delete(conn, %{"id" => game_id}) do
    conn
    |> GuardianPlug.current_resource()
    |> Entries.get_by_game_id!(game_id)
    |> Entries.delete()

    send_resp(conn, :no_content, "")
  end
end
