defmodule Skaro.Reviews.RatingTest do
  @moduledoc false
  use Skaro.DataCase

  alias Skaro.Reviews.Rating

  describe "changeset/1" do
    test "it validates changeset" do
      refute Rating.changeset(%Rating{}, %{
               external_id: 134
             }).valid?
    end

    test "it saves rating record" do
      attrs = %{
        external_id: "1234",
        game_id: 5678,
        game_name: "Game 5678",
        percent_recommended: 89.3,
        score: 79.6666,
        num_reviews: 148,
        tier: "Strong",
        summary: "la blah blah blah",
        points: [
          %{title: "Vast open world", description: "it is really big", state: "pro"},
          %{title: "Boring", description: "it is really boring", state: "con"}
        ],
        reviews: [
          %{
            title: "Good game",
            snippet: "quite a good game",
            score: 80,
            external_link: "https://site1.com"
          },
          %{
            title: "Bad game",
            snippet: "quite a bad game",
            score: 20,
            external_link: "https://site2.com"
          }
        ]
      }

      assert {:ok, rating} =
               %Rating{}
               |> Rating.changeset(attrs)
               |> Repo.insert()

      assert "1234" = rating.external_id

      rating_db = Repo.get!(Rating, rating.id)

      assert rating_db.reviews == [
               %{
                 "external_link" => "https://site1.com",
                 "score" => 80,
                 "snippet" => "quite a good game",
                 "title" => "Good game"
               },
               %{
                 "external_link" => "https://site2.com",
                 "score" => 20,
                 "snippet" => "quite a bad game",
                 "title" => "Bad game"
               }
             ]
    end
  end
end
