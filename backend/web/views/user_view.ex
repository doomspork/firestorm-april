defmodule Firestorm.UserView do
  use Firestorm.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, Firestorm.UserView, "user.json")}
  end

  def render("show.json", %{user: user} = assigns) do
    jwt_token = Map.get(assigns, :jwt_token)
    %{data: render_one(user, Firestorm.UserView, "user.json", jwt_token: jwt_token)}
  end

  def render("user.json", %{user: user, jwt_token: jwt_token}) do
    basics = %{email: user.email,
               id: user.id,
               jwt_token: jwt_token,
               username: user.username}

    unless jwt_token do
      basics = Map.delete(basics, :jwt_token)
    end

    basics
  end
end
