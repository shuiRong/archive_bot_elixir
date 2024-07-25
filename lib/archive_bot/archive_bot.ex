defmodule ArchiveBot.ArchiveBot do
  use Telegram.Bot
  alias ArchiveBot.CommandHandler

  @impl Telegram.Bot
  def handle_update(
        %{
          "message" => %{
            "text" => "/sleep" <> seconds_arg,
            "chat" => %{"id" => chat_id},
            "message_id" => message_id
          }
        },
        token
      ) do
    seconds = seconds_arg |> parse_seconds_arg()
    CommandHandler.sleep(token, chat_id, message_id, seconds)
  end

  def handle_update(
        %{
          "message" => %{
            "text" => text,
            "chat" => %{"id" => chat_id},
            "message_id" => message_id
          }
        },
        token
      ) do
    CommandHandler.archiveURL(token, text)
  end

  defp parse_seconds_arg(arg) do
    default_arg = "1"
    arg = if arg == "", do: default_arg, else: arg
    {seconds, ""} = arg |> String.trim() |> Integer.parse()
    seconds
  end
end
