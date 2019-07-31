defmodule Skaro.Parser do
  @moduledoc """
  parses stuff
  """

  def parse_json(body) do
    case Jason.decode(body) do
      {:ok, json} ->
        {:ok, json}

      {:error, %Jason.DecodeError{}} ->
        {:error, "Invalid json: #{body}"}
    end
  end

  def parse_date(nil), do: nil
  def parse_date(num) when is_integer(num), do: DateTime.from_unix!(num)
end
