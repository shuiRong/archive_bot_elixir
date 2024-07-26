defmodule ArchiveBot.CommandHandler do
  alias ArchiveBot.MarkdownToHtml
  require Logger

  def sleep(token, chat_id, message_id, seconds) do
    Telegram.Api.request(token, "sendMessage",
      chat_id: chat_id,
      reply_to_message_id: message_id,
      text: "Sleeping '#{seconds}'s"
    )

    Process.sleep(seconds * 1_000)

    Telegram.Api.request(token, "sendMessage",
      chat_id: chat_id,
      reply_to_message_id: message_id,
      text: "Awake!"
    )
  end

  def archiveURL(token, text) do
    urls = text |> parseURL(token) |> MarkdownToHtml.convert()
    IO.inspect(urls)
  end

  def parseURL(text, token) do
    IO.puts("Parsing URLs from #{text}, token: #{token}")

    text
    |> URLExtractor.extract()
    |> Enum.reduce([], fn url, acc ->
      case PageFetch.fetch(url) do
        {:ok, body} ->
          case body do
            %{"data" => %{"content" => content}} ->
              [{url, content} | acc]

            _ ->
              IO.puts("Unexpected response structure")
              acc
          end

        {:error, reason} ->
          IO.puts("Error fetching #{url}: #{reason}")
          acc
      end
    end)
    |> Enum.reverse()
  end

  def unknown(token, update) do
    unknown_message = "Unknown message:\n\n```\n#{inspect(update, pretty: true)}\n```"

    case update do
      %{"message" => %{"message_id" => message_id, "chat" => %{"id" => chat_id}}} ->
        Telegram.Api.request(token, "sendMessage",
          chat_id: chat_id,
          reply_to_message_id: message_id,
          parse_mode: "MarkdownV2",
          text: unknown_message
        )

      _ ->
        Logger.debug(unknown_message)
    end
  end
end
