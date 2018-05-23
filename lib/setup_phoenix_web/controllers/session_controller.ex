defmodule SetupPhoenixWeb.SessionController do
  use SetupPhoenixWeb, :controller

  alias SetupPhoenix.Accounts.User
  alias SetupPhoenix.Guardian.Plug

  action_fallback SetupPhoenixWeb.FallbackController

  def new(conn, _params) do
    changeset = User.changeset(%User{})

    with :ok <- Bodyguard.permit(SetupPhoenix.Abilities, :create_session, conn.assigns.current_user, nil)
    do
      render conn, "login.html", changeset: changeset
    end
  end

  def create(conn, %{"user" => user_params}) do

    with :ok <- Bodyguard.permit(SetupPhoenix.Abilities, :create_session, conn.assigns.current_user, nil)
    do
      case User.check_credentials(user_params) do
        {:ok, user} ->
          conn
          |> Plug.sign_in(user)
          |> put_flash(:info, gettext("You have successfully logged in!"))
          |> redirect(to: "/")
        {:error, changeset} ->
          conn
          |> render("login.html", changeset: changeset)
      end
    end
  end

  def destroy(conn, _params) do

    with :ok <- Bodyguard.permit(SetupPhoenix.Abilities, :destroy_session, conn.assigns.current_user, nil)
    do
      conn
      |> Plug.sign_out
      |> put_flash(:info, gettext("You have successfully logged out!"))
      |> redirect(to: "/")
    end

  end

end
