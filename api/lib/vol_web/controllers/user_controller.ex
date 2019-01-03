defmodule VolWeb.UserController do
  use VolWeb, :controller

  alias Vol.Accounts
  alias Vol.Accounts.User

  action_fallback(VolWeb.FallbackController)

  def auth(conn, %{"email" => email, "password" => password}) do
    case Accounts.token_auth(email, password) do
      %{token: {:ok, token, _}, user: user, err: nil} ->
        conn
        |> render("jwt.json",
          jwt: token,
          user: user
        )

      %{err: err} ->
        {:error, err}
    end
  end

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
