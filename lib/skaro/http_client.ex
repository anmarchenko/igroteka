defmodule Skaro.HttpClient do
  @moduledoc """
  Common backend API helpers.
  """
  def get(params, url) do
    case HTTPoison.get(url, [], [{:params, params}]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        parse_json(body)

      {:ok, %HTTPoison.Response{status_code: code}} ->
        {
          :error,
          """
          HTTP status code: #{code}.
          Accessed url: [#{url}].
          Params were: #{inspect(params)}
          """
        }

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  def parse_json(body) do
    case Jason.decode(body) do
      {:ok, json} ->
        {:ok, json}

      {:error, %Jason.DecodeError{}} ->
        {:error, "Invalid json from Giantbomb: #{body}"}
    end
  end
end
