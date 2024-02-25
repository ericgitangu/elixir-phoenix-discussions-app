defmodule DiscussWeb.DiscussionRoomChannel do
  use DiscussWeb, :channel

  @impl true
  def join(name, _message, socket) do
    IO.puts("Joining: #{name}")
    {:ok, %{hey: "there"}, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end
end
