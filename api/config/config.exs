# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :vol,
  ecto_repos: [Vol.Repo]

# Configures the endpoint
config :vol, VolWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pR1eB1gQv5o8Ao6kFmBZbviGWMkT/w44BXsaZPLRUDYqjxoPi12ESSx/GBt/bR9C",
  render_errors: [view: VolWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Vol.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
