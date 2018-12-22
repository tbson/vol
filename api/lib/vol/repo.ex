defmodule Vol.Repo do
  use Ecto.Repo,
    otp_app: :vol,
    adapter: Ecto.Adapters.Postgres
end
