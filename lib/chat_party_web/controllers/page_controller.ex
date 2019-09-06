defmodule ChatPartyWeb.PageController do
  use ChatPartyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def room(conn, %{"name" => room_name} = params) do
    render(conn, "room.html", %{room_name: room_name, username: Map.get(params, "username")})
  end
end
