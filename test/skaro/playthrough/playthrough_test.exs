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

  describe "needs_update?/2" do
    test "every day if game was released within a week" do
      today = NaiveDateTime.utc_now()

      time =
        insert(:playthrough_time, %{
          inserted_at: NaiveDateTime.add(today, -86_401),
          updated_at: NaiveDateTime.add(today, -86_401)
        })

      assert Playthrough.needs_update?(time, today)
      assert Playthrough.needs_update?(time, Date.add(today, -7))
      refute Playthrough.needs_update?(time, Date.add(today, -8))
    end

    test "every week if game was released within a month" do
      today = NaiveDateTime.utc_now()

      time =
        insert(:playthrough_time, %{
          inserted_at: NaiveDateTime.add(today, -604_801),
          updated_at: NaiveDateTime.add(today, -604_801)
        })

      assert Playthrough.needs_update?(time, Date.add(today, -29))
      refute Playthrough.needs_update?(time, Date.add(today, -30))
    end

    test "every month if game was released within 3 months" do
      today = NaiveDateTime.utc_now()

      time =
        insert(:playthrough_time, %{
          inserted_at: NaiveDateTime.add(today, -2_592_001),
          updated_at: NaiveDateTime.add(today, -2_592_001)
        })

      assert Playthrough.needs_update?(time, Date.add(today, -89))
      refute Playthrough.needs_update?(time, Date.add(today, -90))
    end

    test "every 6 months for older games" do
      today = NaiveDateTime.utc_now()

      time =
        insert(:playthrough_time, %{
          inserted_at: NaiveDateTime.add(today, -15_552_001),
          updated_at: NaiveDateTime.add(today, -15_552_001)
        })

      assert Playthrough.needs_update?(time, Date.add(today, -181))
    end
  end

  describe "reload_playthrough_time/1" do
    test "loads data from external api and updates db record" do
      Skaro.PlaythroughRemoteMock
      |> expect(:get_by_id, fn game_id ->
        assert game_id == 404

        {:ok,
         %{
           external_id: "oops",
           external_url: "http://website/42",
           main: 10,
           main_extra: 20,
           completionist: 30
         }}
      end)

      time =
        insert(:playthrough_time,
          external_id: "42",
          game_id: 404,
          main: 60,
          main_extra: 120,
          completionist: 180
        )

      assert {:ok, updated} = Playthrough.reload_playthrough_time(time)

      assert updated.id == time.id
      assert updated.external_id == "42"
      assert updated.main == 10
      assert updated.main_extra == 20
      assert updated.completionist == 30
    end
  end
end
