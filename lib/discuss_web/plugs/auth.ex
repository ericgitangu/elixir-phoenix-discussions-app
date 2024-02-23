defmodule Discuss.Auth do
  import Plug.Conn
  use DiscussWeb, :controller
  import Phoenix.Controller

  alias Discuss.Accounts
  alias Discuss.Repo

  def init(opts), do: opts

  def call(conn, _opts) do
  user_id = get_session(conn, :current_user)
  cond do
    user_id ->
      user = Repo.get(Accounts.Users, user_id)
      assign(conn, :current_user, user)
    true ->
      assign(conn, :current_user, nil)
    end
  end
end
