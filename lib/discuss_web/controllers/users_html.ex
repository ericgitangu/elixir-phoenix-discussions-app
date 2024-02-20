defmodule DiscussWeb.UsersHTML do
  use DiscussWeb, :html

  embed_templates "users_html/*"

  @doc """
  Renders a users form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def users_form(assigns)
end
