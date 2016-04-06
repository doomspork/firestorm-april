defmodule Firestorm.UserTest do
  use Firestorm.ModelCase

  alias Firestorm.User

  @valid_attrs %{email: "test@example.com", password: "some content", username: "test"}
  @invalid_attrs %{}

  test "registration_changeset with valid attributes" do
    changeset = User.registration_changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "registration_changeset with invalid attributes" do
    changeset = User.registration_changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
