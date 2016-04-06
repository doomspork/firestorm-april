defmodule Firestorm.AuthViewTest do
  use Firestorm.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "render 500.html" do
    assert render_to_string(Firestorm.ErrorView, "500.html", []) ==
           "Server internal error"
  end

  test "render any other" do
    assert render_to_string(Firestorm.ErrorView, "505.html", []) ==
           "Server internal error"
  end
end

