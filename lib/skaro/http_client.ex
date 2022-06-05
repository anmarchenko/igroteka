defmodule Skaro.HttpClient do
  @moduledoc """
  Common backend API helpers.
  """

  @retries 5

  def get(url, params \\ %{}, headers \\ []) do
    get_with_retries(url, params, headers, @retries)
  end

  def idempotent_post(url, body, headers) do
    post_with_retries(url, body, headers, @retries)
  end

  defp post_with_retries(url, body, headers, retries) do
    case url
         |> HTTPoison.post(body, headers, timeout: 2_000, recv_timeout: 2_000)
         |> retrieve_body() do
      {:ok, body} ->
        body

      {:error, _} = error_tuple ->
        if retries > 0 do
          post_with_retries(url, body, headers, retries - 1)
        else
          error_tuple
        end
    end
  end

  defp get_with_retries(url, params, headers, retries) do
    case HTTPoison.get(url, headers, [{:params, params}]) do
      {:ok, %HTTPoison.Response{status_code: code, body: body}} when code < 400 ->
        body

      {:ok, %HTTPoison.Response{status_code: code}} ->
        if retries > 0 do
          get_with_retries(url, params, headers, retries - 1)
        else
          {
            :error,
            """
            HTTP status code: #{code}.
            Accessed url: [#{url}].
            Params were: #{inspect(params)}
            """
          }
        end

      {:error, %HTTPoison.Error{reason: reason}} ->
        if retries > 0 do
          get_with_retries(url, params, headers, retries - 1)
        else
          {:error, reason}
        end
    end
  end

  defp retrieve_body({:error, %HTTPoison.Error{reason: reason}}), do: {:error, reason}

  defp retrieve_body({:ok, %HTTPoison.Response{status_code: code, body: body}}) when code < 400,
    do: {:ok, body}

  defp retrieve_body({:ok, %HTTPoison.Response{status_code: code}}),
    do: {:error, "HTTP status code: #{code}."}
end
