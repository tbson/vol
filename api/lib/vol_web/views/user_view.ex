defmodule VolWeb.UserView do
  use VolWeb, :view
  alias VolWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      firstname: user.firstname,
      middlename: user.middlename,
      lastname: user.lastname
    }
  end

  def render("jwt.json", %{token: token, user: user}) do
    %{token: token, user: user}
  end
end
