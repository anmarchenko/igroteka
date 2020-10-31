defmodule Skaro.Opencritic.Mapper do
  @moduledoc """
  Provides transformations for opencritic data
  """

  def review_summary(%{"completed" => true} = summary) do
    %{
      summary: summary["summary"],
      points: slots(summary, 1)
    }
  end

  def review_summary(_), do: %{}

  def reviews(reviews_json) do
    reviews_json
    |> Enum.map(&review/1)
    |> Enum.filter(&(&1 != nil))
  end

  defp review(%{"Outlet" => %{"name" => name}} = review_json) do
    %{
      name: name,
      snippet: review_json["snippet"],
      score: review_json["score"],
      external_url: review_json["externalUrl"]
    }
  end

  defp review(_), do: nil

  defp slots(json, num) do
    slot = "slot#{num}"

    if json[slot] do
      [
        %{
          title: json[slot],
          state: json["#{slot}State"],
          description: json["#{slot}P"]
        }
      ] ++ slots(json, num + 1)
    else
      []
    end
  end
end
