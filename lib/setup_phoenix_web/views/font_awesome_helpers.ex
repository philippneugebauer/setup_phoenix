defmodule SetupPhoenixWeb.FontAwesomeHelpers do
  use Phoenix.HTML

  def icon(icon, icon_group \\ "fa", text \\ nil, title \\ nil) do
    Phoenix.HTML.raw("<span class='#{icon_group} fa-#{icon}' title='#{title}'></span> #{text}")
  end

  def edit_icon(text \\ nil) do
    icon("pencil-alt", "fas", text)
  end

  def add_icon(text \\ nil) do
    icon("plus", "fas", text)
  end

  def delete_icon(text \\ nil) do
    icon("trash-alt", "far", text)
  end

  def show_icon(text \\ nil) do
    icon("search-plus", "fas", text)
  end
end