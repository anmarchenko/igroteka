defmodule Skaro.Howlongtobeat.Client do
  @moduledoc """
  HowLongToBeat client retrieves and parses information from https://howlongtobeat.com
  """

  alias Skaro.HttpClient
  # {:ok, document} <- Floki.parse_document(body)
  def find(%{name: name, release_date: _release_date}) do
    with body when is_binary(body) <-
           HttpClient.idempotent_post(
             search_url(),
             {:form,
              [
                {:queryString, name},
                {:t, "games"},
                {:sorthead, "popular"},
                {:sortd, "Normal Order"},
                {:length_type, "main"}
              ]},
             [
               {"Accept", "application/x-www-form-urlencoded"}
             ]
           ) do
      {:ok, body}
    end
  end

  defp search_url, do: "https://howlongtobeat.com/search_results?page=1"
end
