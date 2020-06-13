defmodule Skaro.Playthrough.PlaythroughTimeTest do
  @moduledoc false
  use Skaro.DataCase

  alias Skaro.Playthrough.PlaythroughTime

  describe "changeset/1" do
    test "it validates changeset" do
      refute PlaythroughTime.changeset(%PlaythroughTime{}, %{
               external_id: 134,
               external_url: "http://howlongtobeat.com/134"
             }).valid?
    end

    test "it saves playthrough time record" do
      attrs = %{
        external_id: "1234",
        external_url: "http://howlongtobeat.com//game?id=1234",
        game_id: 5678,
        game_name: "Game 5678",
        main: 12 * 60,
        main_extra: 20 * 60,
        completionist: 40 * 60
      }

      assert {:ok, playhtrough_time} =
               %PlaythroughTime{}
               |> PlaythroughTime.changeset(attrs)
               |> Repo.insert()

      assert "1234" = playhtrough_time.external_id
      assert 720 = playhtrough_time.main
    end
  end
end
