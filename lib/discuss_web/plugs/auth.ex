defmodule Discuss.Auth do
  import Plug.Conn
  use DiscussWeb, :controller
  # import Phoenix.Controller
  alias Discuss.Accounts

  def init(opts), do: opts

  def call(conn, _opts) do
    IO.puts("+++++++******************++++++")
    IO.inspect(conn)
    IO.puts("+++++++******************++++++")
    user_id = get_session(conn, :user_id)
    cond do
       user = user_id && Accounts.get_user_by_id(user_id)->
          put_session(conn, :user_id, user.id)
          put_session(conn, "_csrf_token", Process.get(:csrf_token))
          assign(conn, :user, user)
       true ->
         assign(conn, :user, nil)
     end
  end
end
