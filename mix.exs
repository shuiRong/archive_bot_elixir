defmodule ArchiveBot.MixProject do
  use Mix.Project

  def project do
    [
      app: :archive_bot,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ArchiveBot.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:telegram, github: "visciang/telegram", branch: "master"},
      {:hackney, "~> 1.18"},
      {:httpoison, "~> 1.8"},
      {:exsync, "~> 0.4", only: :dev},
      {:dotenv, "~> 3.0.0"},
      {:earmark, "~> 1.4"}
    ]
  end
end
