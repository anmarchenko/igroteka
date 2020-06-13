defmodule Skaro.PlaythroughTest do
  @moduledoc false
  use Skaro.DataCase

  import Mox
  import Skaro.Factory

  alias Skaro.Core.Game
  alias Skaro.Playthrough
  alias Skaro.Playthrough.PlaythroughTime
  alias Skaro.Repo

  setup :verify_on_exit!

  describe "find/1" do
    test "no local data found and external api call succeeded" do
      Skaro.PlaythroughRemoteMock
      |> expect(:find, fn %{name: name, release_date: release_date} ->
        assert "Warcraft" == name
        assert ~D[1995-01-01] == release_date

        {:ok,
         %{
           external_id: "42",
           external_url: "http://website/42",
           main: 60,
           main_extra: 120,
           completionist: 180
         }}
      end)

      assert {:ok,
              %PlaythroughTime{
                id: id,
                game_id: 101,
                game_name: "Warcraft",
                external_id: "42",
                external_url: "http://website/42",
                main: 60,
                main_extra: 120,
                completionist: 180
              }} =
               Playthrough.find(%Game{id: 101, name: "Warcraft", release_date: ~D[1995-01-01]})

      assert Repo.get!(PlaythroughTime, id)
    end

    test "local data found" do
      %PlaythroughTime{id: id} = insert(:playthrough_time, %{game_name: "Warcraft", game_id: 101})

      assert {:ok,
              %PlaythroughTime{
                id: ^id,
                game_name: "Warcraft"
              }} =
               Playthrough.find(%Game{id: 101, name: "Warcraft", release_date: ~D[1995-01-01]})
    end

    test "no local data found and external api call errored" do
      Skaro.PlaythroughRemoteMock
      |> expect(:find, fn _ ->
        {:error, "No times found"}
      end)

      assert {:error, "No times found"} =
               Playthrough.find(%Game{id: 101, name: "Warcraft", release_date: ~D[1995-01-01]})
    end
  end
end
