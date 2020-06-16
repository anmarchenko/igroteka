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

  describe "category_badge/1" do
    test "wrong data" do
      assert %{} == Playthrough.category_badge(%PlaythroughTime{main: "12"})
      assert %{} == Playthrough.category_badge(%PlaythroughTime{main: nil})
      assert %{} == Playthrough.category_badge(%PlaythroughTime{})
    end

    test "very short game" do
      assert %{badge: "very-short", badge_label: "Very short"} ==
               Playthrough.category_badge(%PlaythroughTime{main: 0})

      assert %{badge: "very-short", badge_label: "Very short"} ==
               Playthrough.category_badge(%PlaythroughTime{main: 360})
    end

    test "short game" do
      assert %{badge: "short", badge_label: "Short"} ==
               Playthrough.category_badge(%PlaythroughTime{main: 361})

      assert %{badge: "short", badge_label: "Short"} ==
               Playthrough.category_badge(%PlaythroughTime{main: 720})
    end

    test "fair length game" do
      assert %{badge: "fair", badge_label: "Fair length"} ==
               Playthrough.category_badge(%PlaythroughTime{main: 721})

      assert %{badge: "fair", badge_label: "Fair length"} ==
               Playthrough.category_badge(%PlaythroughTime{main: 1080})
    end

    test "average length game" do
      assert %{badge: "average", badge_label: "Average length"} ==
               Playthrough.category_badge(%PlaythroughTime{main: 1081})

      assert %{badge: "average", badge_label: "Average length"} ==
               Playthrough.category_badge(%PlaythroughTime{main: 2160})
    end

    test "long game" do
      assert %{badge: "long", badge_label: "Long"} ==
               Playthrough.category_badge(%PlaythroughTime{main: 2161})

      assert %{badge: "long", badge_label: "Long"} ==
               Playthrough.category_badge(%PlaythroughTime{main: 4320})
    end

    test "very long game" do
      assert %{badge: "very-long", badge_label: "Very long"} ==
               Playthrough.category_badge(%PlaythroughTime{main: 4321})
    end
  end
end
