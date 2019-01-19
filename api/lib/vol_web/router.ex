defmodule VolWeb.Router do
  use VolWeb, :router
  alias Vol.Guardian.AuthPipeline

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :jwt_authenticated do
    plug(AuthPipeline)
  end

  scope "/api/v1", VolWeb do
    pipe_through(:api)

    post("/auth", UserController, :auth)
  end

  scope "/api/v1", VolWeb do
    pipe_through([:api, :jwt_authenticated])

    resources("/users", UserController, except: [:new, :edit])
    resources("/variables", VariableController, except: [:new, :edit])
  end
end
