defmodule ChatPartyWeb.Router do
  use ChatPartyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ChatPartyWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/room", PageController, :room
  end

  # Other scopes may use custom stacks.
  # scope "/api", ChatPartyWeb do
  #   pipe_through :api
  # end
end
