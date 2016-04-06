defmodule Firestorm.AuthController do
  use Firestorm.Web, :controller

  plug Ueberauth

  alias Firestorm.{User, UserView}
  alias Comeonin.Bcrypt

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case user_from_auth(auth) do
      {:ok, user} ->
        valid = validate_pass(user.encrypted_password, auth.credentials.other.password)
        if valid do
          token = signin_user(conn, user)

          conn
          |> put_status(:created)
          |> render(UserView, "show.json", user: user, token: token)
        else
          conn
          |> put_status(:bad_request)
          |> render("error.json", error: "invalid login information")
        end
      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", error: reason)
    end
  end

  def logout(conn, _params) do
    conn
    |> Guardian.Plug.sign_out
    |> send_resp(:no_content, "")
  end

  defp signin_user(conn, user) do
    conn
    |> Guardian.Plug.api_sign_in(user)
    |> Guardian.Plug.current_token
  end

  defp user_from_auth(auth) do
    case Repo.one(User, email: auth.info.email) do
      nil -> {:error, "invalid username"}
      user -> {:ok, user}
    end
  end

  defp validate_pass(_encrypted, password) when password in [nil, ""] do
    {:error, "password required"}
  end
  defp validate_pass(encrypted, password) do
    Bcrypt.checkpw(password, encrypted)
  end
end
