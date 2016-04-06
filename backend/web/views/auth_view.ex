defmodule Firestorm.AuthView do
  use Firestorm.Web, :view

  def render("error.json", %{error: reason}) do
    %{error: reason}
  end
end
