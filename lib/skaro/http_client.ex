defmodule Skaro.HttpClient do
  @moduledoc """
  Common backend API helpers.
  """

  @retries 5

  def get(params, url) do
    case HTTPoison.get(url, [], [{:params, params}]) do
      {:ok, %HTTPoison.Response{status_code: code, body: body}} when code < 400 ->
        body

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

  def idempotent_post(url, body, headers) do
    post_with_retries(url, body, headers, @retries)
  end

  defp post_with_retries(url, body, headers, retries) do
    case HTTPoison.post(url, body, headers) do
      {:ok, %HTTPoison.Response{status_code: code, body: body}} when code < 400 ->
        body

      {:ok, %HTTPoison.Response{status_code: code}} ->
        {
          :error,
          """
          HTTP status code: #{code}.
          Accessed url: [#{url}].
          Request body was: #{body}
          """
        }

      {:error, %HTTPoison.Error{reason: reason}} ->
        if retries > 0 do
          post_with_retries(url, body, headers, retries - 1)
        else
          {:error, reason}
        end
    end
  end
end
