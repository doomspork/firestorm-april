defmodule Firestorm.AuthControllerTest do
  use Firestorm.ConnCase

  alias Firestorm.User

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates a valid token for given resource", %{conn: conn} do
    user = %User{}
           |> User.registration_changeset(%{email: "test@example.com", password: "password1", username: "test"})
           |> Repo.insert!

    conn = post conn, auth_path(conn, :callback), %{email: user.email, password: "password1"}
    assert json_response(conn, 201)["data"] == %{"email" => user.email, "id" => user.id, "username" => user.username}
  end

  test "does not create a token with invalid password", %{conn: conn} do
    user = %User{}
           |> User.registration_changeset(%{email: "test@example.com", password: "password1", username: "test"})
           |> Repo.insert!

    conn = post conn, auth_path(conn, :callback), %{email: user.email, password: "password2"}
    assert json_response(conn, 400)["error"] != %{}
  end

  test "does not create a token for invalid resource", %{conn: conn} do
    conn = post conn, auth_path(conn, :callback), %{email: "missing@example.com", password: "password1"}
    assert json_response(conn, 400)["error"] != %{}
  end
end
