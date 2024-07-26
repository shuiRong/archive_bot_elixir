defmodule ArchiveBot.MarkdownToHtml do
  # 导入Earmark库
  require Earmark

  def convert(markdown) do
    Earmark.as_html!(markdown)
  end
end
