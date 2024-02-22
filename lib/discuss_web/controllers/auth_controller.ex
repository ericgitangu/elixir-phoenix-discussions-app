defmodule DiscussWeb.AuthController do
  use Phoenix.Controller
  plug Ueberauth
  alias Discuss.Accounts

  def callback_phase(%{assigns: %{ueberauth_failure: fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Authentication failed: #{fails.reason}")
    |> redirect(to: "/")
  end

  def callback_phase(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    nickname = auth.info.nickname
    email = auth.info.email
    token = auth.credentials.token

    conn
    |> put_session(:ueberauth_auth_info, nickname)
    |> put_flash(:info, "Welcome, #{nickname}!")
    |> put_resp_cookie("authorization", "Token Bearer: #{token}")
    |> put_req_header("authorization", "Token Bearer: #{token}")
    |> Accounts.get_or_create_user(email, nickname)
    |> redirect(to: "/topics")
  end
  def logout(conn, _params) do
      conn
      |> put_flash(:info, "Logged out successfully.")
      |> put_session(:current_user, nil)
      |> delete_resp_cookie("authorization")
      |> put_req_header("authorization", "")
      |> configure_session(drop: true)
      |> redirect(to: "/")
  end

  def request(conn, %{"provider" => provider}) do
    render(conn, "request.html", callback_url: callback_url(provider, conn))
  end

  def callback_url(_provider, conn) do
    conn
    |> put_flash(:info, "Callback URL")
    |> redirect(to: "/")
  end
end
