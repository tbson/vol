defmodule VolWeb.Router do
  use VolWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", VolWeb do
    pipe_through :api
  end
end
