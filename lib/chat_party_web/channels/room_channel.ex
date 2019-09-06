defmodule ChatPartyWeb.RoomChannel do
  use Phoenix.Channel

  alias Faker.Name.PtBr, as: Faker

  def join("room:" <> room_name, params, socket) do
    username =
      case Map.get(params, "username") do
        "" -> Faker.first_name()
        username -> username
      end

    send(self(), {:after_join, username})
    {:ok, assign(socket, :username, username)}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    username = socket.assigns.username
    broadcast!(socket, "new_msg", %{body: body, username: username})
    {:noreply, socket}
  end

  def handle_info({:after_join, username}, socket) do
    broadcast!(socket, "new_msg", %{body: "**#{username}** entrou na sala.", username: "INFO"})
    {:noreply, socket}
  end

  def terminate(reason, socket) do
    username = socket.assigns.username
    broadcast!(socket, "new_msg", %{body: "**#{username}** saiu da sala.", username: "INFO"})
    {:noreply, socket}
  end
end
