defmodule ArchiveBot.Application do
  use Application

  def start(_type, _args) do
    bot_token = System.get_env("BOT_TOKEN")

    if bot_token == nil do
      IO.puts(:stderr, "Please provide a BOT_TOKEN environment variable")
      System.halt(1)
    end

    children = [
      {Telegram.Poller,
       bots: [{ArchiveBot.ArchiveBot, token: bot_token, max_bot_concurrency: 1_000}]}
      # 在这里添加你的其他子进程
    ]

    opts = [strategy: :one_for_one, name: ArchiveBot.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
