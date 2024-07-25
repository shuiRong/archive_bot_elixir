defmodule PageFetch do
  use HTTPoison.Base

  def fetch(url) do
    IO.puts("Fetching #{url}")
    case get("https://r.jina.ai/#{url}") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}

      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        {:error, "Request failed with status code: #{status_code}"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
