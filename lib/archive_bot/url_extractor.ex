defmodule URLExtractor do
  @url_regex ~r/https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&\/\/=]*)/

  def extract(text) do
    Regex.scan(@url_regex, text)
    |> Enum.map(&List.first/1)
    |> Enum.uniq()
  end
end
