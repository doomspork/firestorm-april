defmodule Firestorm.UserTest do
  use Firestorm.ModelCase

  alias Firestorm.User

  @valid_attrs %{email: "test@example.com", encrypted_password: "some content", username: "test"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
