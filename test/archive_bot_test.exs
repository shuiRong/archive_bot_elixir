defmodule ArchiveBotTest do
  use ExUnit.Case
  doctest ArchiveBot

  test "greets the world" do
    assert ArchiveBot.hello() == :world
  end
end
