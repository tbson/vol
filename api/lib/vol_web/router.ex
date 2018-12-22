defmodule VolWeb.Router do
  use VolWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api/v1", VolWeb do
    pipe_through(:api)
    resources("/users", UserController, except: [:new, :edit])
  end
end
