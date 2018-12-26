use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :vol, VolWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :vol, Vol.Repo,
  username: "postgres",
  password: "postgres",
  database: "vol_test",
  hostname: "vol_db",
  pool: Ecto.Adapters.SQL.Sandbox
