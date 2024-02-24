defmodule Discuss.Plugs.Verify do
  import Plug.Conn
  import Phoenix.Controller

  def init(_params) do
  # This is a no-op
    []
  end

  def call(conn, _params) do
    user_id = get_session(conn, :current_user)
    cond do
      user_id ->
        conn
      user_id == nil ->
        conn
        |> put_session(:status, 403)
        |> put_flash(:error, "Action forbidden, you must be log in.")
        |> redirect(to: "/"<>List.first(conn.path_info))
        |> halt()
      true ->
        assign(conn, :current_user, nil)
    end
  end
end
