defmodule PageFetch do
  use HTTPoison.Base

  def fetch(url) do
    IO.puts("Fetching #{url}")

    headers = [
      {"X-Return-Format", "markdown"},
      {"Accept", "application/json"}
    ]

    case get("https://r.jina.ai/#{url}", headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        case Jason.decode(body) do
          {:ok, parsed_body} ->
            {:ok, parsed_body}

          {:error, _reason} ->
            {:error, "Failed to parse JSON"}
        end

      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        {:error, "Request failed with status code: #{status_code}"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
