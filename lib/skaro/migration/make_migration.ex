defmodule Skaro.Migration.MakeMigration do
  @moduledoc """
  Generates migration to IGDB
  """

  alias Skaro.IGDB

  @platforms_mapping %{
    "PC" => [
      %{name: "PC (Microsoft Windows)", id: 6},
      %{name: "PC DOS", id: 13}
    ],
    "Mac" => [%{name: "Mac", id: 14}],
    "Nintendo Switch" => [%{name: "Nintendo Switch", id: 130}],
    "PlayStation 4" => [%{name: "PlayStation 4", id: 48}],
    "Android" => [%{name: "Android", id: 34}],
    "Xbox 360" => [%{name: "Xbox 360", id: 12}],
    "Nintendo Entertainment System" => [
      %{name: "Nintendo Entertainment System (NES)", id: 18},
      %{name: "Family Computer Disk System"}
    ],
    "iPhone" => [%{name: "iOS", id: 39}]
  }

  def run do
    res =
      "./backlog.csv"
      |> File.read!()
      |> String.split("\n")
      |> Enum.map(fn line ->
        [entry_id, _, _, owned_platform_name, _, igdb_id, _, _] = String.split(line, ",")
        {entry_id, igdb_id, owned_platform_name}
      end)
      |> Enum.map(fn {entry_id, igdb_id, owned_platform_name} ->
        {:ok, game} = IGDB.find_one(igdb_id)

        platform =
          Enum.find(@platforms_mapping[owned_platform_name], fn pl ->
            Enum.find(game.platforms, fn gpl ->
              pl.name == gpl.name
            end) != nil
          end)

        if platform == nil do
          raise "platform is nil for game #{game.name}"
        end

        {entry_id, game, platform}
      end)
      |> Enum.map(fn {entry_id, game, platform} ->
        "{#{entry_id}, #{inspect(SkaroWeb.GameView.render("show.json", %{game: game}))}, #{
          inspect(SkaroWeb.PlatformView.render("platforms_short.json", %{platform: platform}))
        }}"
      end)
      |> Enum.join(",\n")

    File.write("./mapping.ex", res)
  end
end
