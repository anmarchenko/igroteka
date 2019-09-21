defmodule Skaro.Migration.MakeList do
  @moduledoc """
  this function will create a list of what and how to migrate
  """

  alias Skaro.Backlog.Entry
  alias Skaro.Core.Game
  alias Skaro.{IGDB, Repo}

  import Ecto.Query

  def run() do
    data =
      from(e in Entry, where: e.user_id == 2)
      |> Repo.all()
      |> Enum.map(fn e ->
        ig = igdb_game(e.game_name)

        "#{e.id},#{e.game_name},#{year_from_date(e.game_release_date)},#{e.owned_platform_name},#{
          ig.name
        },#{ig.external_id},#{year_from_date(ig.release_date)},#{ig.external_url}"
      end)
      |> Enum.join("\n")

    File.write!("./backlog.csv", data)
  end

  defp year_from_date(nil), do: ""
  defp year_from_date(date), do: date.year

  defp igdb_game(name) do
    case IGDB.search(name) do
      {:ok, [res | _]} ->
        res

      {:ok, []} ->
        %Game{name: "NOT FOUND", external_id: -1, release_date: nil, external_url: ""}
    end
  end
end
