defmodule Vol.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :vol,
    module: Vol.Guardian,
    error_handler: Vol.AuthErrorHandler

  plug(Guardian.Plug.VerifyHeader, realm: "Bearer")
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource)
end
