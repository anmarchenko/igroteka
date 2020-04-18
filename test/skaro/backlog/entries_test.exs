defmodule Skaro.EntriesTest do
  @moduledoc false
  use Skaro.DataCase

  import Skaro.Factory

  alias Skaro.Backlog.{AvailablePlatform, Entries, Entry}
  alias Skaro.Repo

  setup do
    user = insert(:user)

    {:ok, %{user: user}}
  end

  describe "Entries.add/3" do
    test "creates new backlog entry if params are valid", %{user: user} do
      assert {:ok, entry} =
               Entries.add(
                 %{
                   "game_id" => 1234,
                   "game_name" => "XCom 2",
                   "poster_thumb_url" => "http://example.com/image.png",
                   "game_release_date" => "1996-02-29",
                   "note" => "Steam: 50 eur",
                   "status" => "wishlist",
                   "expectation_rating" => 4
                 },
                 user,
                 [%{"platform_id" => 42, "platform_name" => "PC"}]
               )

      assert entry.user_id == user.id
      assert entry.game_id == 1234
      assert entry.game_name == "XCom 2"
      assert entry.status == "wishlist"
      assert entry.poster_thumb_url == "http://example.com/image.png"
      assert entry.note == "Steam: 50 eur"
      assert entry.game_release_date == ~D[1996-02-29]
      assert entry.expectation_rating === 4

      assert Enum.count(entry.available_platforms) == 1
      platform = Enum.fetch!(entry.available_platforms, 0)

      assert platform.platform_id == 42
      assert platform.platform_name == "PC"

      db_platform =
        Repo.get_by!(
          AvailablePlatform,
          entry_id: entry.id
        )

      assert 42 == db_platform.platform_id
    end

    test "creates new backlog entry even if platforms are missing", %{user: user} do
      assert {:ok, entry} =
               Entries.add(
                 %{
                   "game_id" => 1234,
                   "game_name" => "XCom 2",
                   "note" => "Steam: 50 eur",
                   "status" => "backlog"
                 },
                 user,
                 []
               )

      assert entry.user_id == user.id
      assert entry.game_id == 1234
    end

    test "returns error if required param is missing", %{user: user} do
      assert {:error, changeset} =
               Entries.add(
                 %{
                   "game_name" => "XCom 2",
                   "note" => "Steam: 50 eur",
                   "status" => "wishlist"
                 },
                 user
               )

      assert changeset.errors()[:game_id] == {
               "can't be blank",
               [validation: :required]
             }
    end

    test "returns error if status is invalid", %{user: user} do
      assert {:error, changeset} =
               Entries.add(
                 %{
                   "game_id" => 1234,
                   "game_name" => "XCom 2",
                   "note" => "Steam: 50 eur",
                   "status" => "custom status"
                 },
                 user
               )

      assert {
               "is invalid",
               [validation: :inclusion, enum: _]
             } = changeset.errors()[:status]
    end

    test "returns error if trying to insert twice the same game_id for user", %{
      user: user
    } do
      insert(:backlog_entry, user: user, game_id: 1234)

      assert {:error, changeset} =
               Entries.add(
                 %{
                   "game_id" => 1234,
                   "game_name" => "XCom 2",
                   "note" => "Steam: 50 eur",
                   "status" => "backlog"
                 },
                 user
               )

      assert {"has already been taken", _} = changeset.errors()[:game_id]
    end
  end

  describe "Entries.update/2" do
    test "change status and add more data to entry" do
      entry = insert(:backlog_entry)

      assert {:ok, updated_entry} =
               Entries.update(entry, %{
                 "status" => "beaten",
                 "note" => "Just finished this game!!!!",
                 "score" => 5,
                 "owned_platform_id" => 42,
                 "owned_platform_name" => "PlayStation 4",
                 "finished_at" => "2017-07-12",
                 "expectation_rating" => 1
               })

      assert updated_entry.game_name == entry.game_name
      assert "beaten" == updated_entry.status
      assert "Just finished this game!!!!" == updated_entry.note
      assert 5 == updated_entry.score
      assert 42 == updated_entry.owned_platform_id
      assert "PlayStation 4" == updated_entry.owned_platform_name
      assert ~D[2017-07-12] == updated_entry.finished_at
      assert 1 === updated_entry.expectation_rating
    end

    test "returns changeset error if status is wrong" do
      entry = insert(:backlog_entry)

      assert {:error, changeset} =
               Entries.update(entry, %{
                 "status" => "beaten!",
                 "note" => "Just finished this game!!!!",
                 "score" => 5,
                 "owned_platform_id" => 42,
                 "owned_platform_name" => "PlayStation 4",
                 "finished_at" => "2017-07-12"
               })

      assert {
               "is invalid",
               [validation: :inclusion, enum: _]
             } = changeset.errors()[:status]
    end

    test "returns changeset error if date is invalid" do
      entry = insert(:backlog_entry)

      assert {:error, changeset} =
               Entries.update(entry, %{
                 "status" => "beaten",
                 "note" => "Just finished this game!!!!",
                 "score" => 5,
                 "owned_platform_id" => 42,
                 "owned_platform_name" => "PlayStation 4",
                 "finished_at" => "fdfdfds"
               })

      assert changeset.errors()[:finished_at] == {
               "is invalid",
               [type: :date, validation: :cast]
             }
    end
  end

  describe "Entries.delete/1" do
    test "destroys backlog entry together with its available platforms" do
      entry = insert(:backlog_entry)
      assert 1 == Repo.aggregate(Entry, :count, :id)
      assert 2 == Repo.aggregate(AvailablePlatform, :count, :id)
      Entries.delete(entry)
      assert 0 == Repo.aggregate(Entry, :count, :id)
      assert 0 == Repo.aggregate(AvailablePlatform, :count, :id)
    end
  end

  describe "Entries.list/3" do
    test "it returns entries by user", %{user: user} do
      insert_list(12, :backlog_entry, user: user)
      insert_list(1, :backlog_entry)
      assert 13 == Repo.aggregate(Entry, :count, :id)

      backlog_entries = Entries.list(user, %{"page_size" => "20"})
      assert 1 == backlog_entries.page_number
      assert 20 == backlog_entries.page_size
      assert 1 == backlog_entries.total_pages
      assert 12 == Enum.count(backlog_entries.entries)

      backlog_entry = List.first(backlog_entries.entries)
      assert backlog_entry.available_platforms
      assert "wishlist" == backlog_entry.status
    end

    test "it filters by status", %{user: user} do
      insert_list(1, :backlog_entry, user: user)
      insert_list(2, :backlog_entry, user: user, status: "backlog")
      backlog_entries = Entries.list(user, %{"status" => "backlog"})
      assert 2 == Enum.count(backlog_entries.entries)
    end

    test "it filters by owned_platform_id", %{user: user} do
      insert_list(3, :backlog_entry, user: user)
      insert_list(1, :backlog_entry, user: user, status: "backlog")

      insert_list(
        2,
        :backlog_entry,
        user: user,
        status: "backlog",
        owned_platform_id: 23_556
      )

      backlog_entries =
        Entries.list(user, %{
          "status" => "backlog",
          "owned_platform_id" => 23_556
        })

      assert 2 == Enum.count(backlog_entries.entries)
    end

    test "it orders by insertion time", %{user: user} do
      insert(:backlog_entry, user: user, inserted_at: ~N[2018-01-01 01:00:00])
      insert(:backlog_entry, user: user, inserted_at: ~N[2018-01-01 00:00:00])
      insert(:backlog_entry, user: user, inserted_at: ~N[2018-01-01 02:00:00])

      backlog_entries =
        Entries.list(user, %{
          "sort" => "desc:inserted_at"
        })

      backlog_entries
      |> Enum.map(& &1.inserted_at)
      |> Enum.reduce(~N[2120-01-01 00:00:00], fn val, acc ->
        assert Timex.before?(val, acc)
        val
      end)
    end

    test "it orders by finishing date", %{user: user} do
      insert(:backlog_entry, user: user, finished_at: ~D[2018-02-02])
      insert(:backlog_entry, user: user, finished_at: ~D[2017-04-01])
      insert(:backlog_entry, user: user, finished_at: ~D[2019-08-12])

      backlog_entries =
        Entries.list(user, %{
          "sort" => "asc:finished_at"
        })

      backlog_entries
      |> Enum.map(& &1.finished_at)
      |> Enum.reduce(~D[1960-01-01], fn val, acc ->
        assert Timex.before?(acc, val)
        val
      end)
    end

    test "it orders by finishing date and nulls are always last", %{user: user} do
      insert(:backlog_entry, user: user, finished_at: nil, note: "1")
      insert(:backlog_entry, user: user, finished_at: ~D[2018-01-01], note: "2")
      insert(:backlog_entry, user: user, finished_at: ~D[2018-02-01], note: "3")

      %{entries: [%Entry{note: "2"}, %Entry{note: "3"}, %Entry{note: "1"}]} =
        Entries.list(user, %{
          "sort" => "asc:finished_at"
        })

      %{entries: [%Entry{note: "3"}, %Entry{note: "2"}, %Entry{note: "1"}]} =
        Entries.list(user, %{
          "sort" => "desc:finished_at"
        })
    end
  end

  describe "Entries.get_by_game_id!/2" do
    test "it returns backlog entry for user and given game_id", %{user: user} do
      entry = insert(:backlog_entry, user: user)
      found_entry = Entries.get_by_game_id!(user, entry.game_id)
      assert found_entry.id == entry.id
    end
  end

  describe "Entries.list_years_filter/2" do
    test "it returns distinct years values by user and status", %{user: user} do
      insert(:backlog_entry, user: user, status: "beaten", game_release_date: ~D[2013-09-22])
      insert(:backlog_entry, user: user, status: "beaten", game_release_date: ~D[2011-12-03])
      insert(:backlog_entry, user: user, status: "beaten", game_release_date: nil)
      insert(:backlog_entry, user: user, status: "beaten", game_release_date: ~D[2019-02-04])
      insert(:backlog_entry, user: user, status: "beaten", game_release_date: ~D[2019-04-04])
      insert(:backlog_entry, user: user, status: "beaten", game_release_date: ~D[2018-02-04])
      insert(:backlog_entry, user: user, status: "playing", game_release_date: ~D[2017-09-30])
      insert(:backlog_entry, status: "beaten", game_release_date: ~D[2016-06-21])

      assert [2019, 2018, 2013, 2011] = Entries.list_years_filter(user, "beaten")
    end
  end
end
