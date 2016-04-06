defmodule Firestorm.UserView do
  use Firestorm.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, Firestorm.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, Firestorm.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      encrypted_password: user.encrypted_password,
      username: user.username}
  end
end
