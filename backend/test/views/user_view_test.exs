defmodule Firestorm.UserViewTest do
  use Firestorm.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "render show.json without token" do
    user = %{email: "test@example.com", id: 1, username: "test"}

    assert render(Firestorm.UserView, "show.json", user: user) == %{data: %{email: "test@example.com", id: 1, username: "test"}}
  end

  test "render show.json with token" do
    user = %{email: "test@example.com", id: 1, username: "test"}
    token = "alongstring"

    assert render(Firestorm.UserView, "show.json", user: user, jwt_token: token) == %{data: %{email: "test@example.com", id: 1, jwt_token: token, username: "test"}}
  end
end
