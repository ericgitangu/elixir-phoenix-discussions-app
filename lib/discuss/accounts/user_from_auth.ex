defmodule UserFromAuth do

  require Logger
  require Jason

  alias Ueberauth.Auth

def get_basic_info_github(%Auth{provider: "github", info: %{email: email, name: name, nickname: nickname, image: image}}) do
    {:ok, %{email: email, name: name, nickname: nickname, image: image}}
  end
end
