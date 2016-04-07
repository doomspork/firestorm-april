defmodule Firestorm.UserView do
  use Firestorm.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, Firestorm.UserView, "user.json")}
  end

  def render("show.json", %{user: user, jwt_token: jwt_token}) do
    %{data: render_one(user, Firestorm.UserView, "user_token.json", jwt_token: jwt_token)}
  end
  def render("show.json", %{user: user}) do
    %{data: render_one(user, Firestorm.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{email: user.email,
      id: user.id,
      username: user.username}
  end

  def render("user_token.json", %{user: user, jwt_token: jwt_token}) do
    %{email: user.email,
      id: user.id,
      jwt_token: jwt_token,
      username: user.username}
  end
end
