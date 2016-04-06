defmodule Firestorm.UserViewTest do
  use Firestorm.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "render show.json" do
    user = %{email: "test@example.com", id: 1, username: "test"}

    assert render(Firestorm.UserView, "show.json", user: user) == %{data: %{email: "test@example.com", id: 1, username: "test"}}
  end
end
