defmodule SetupPhoenixWeb.UserController do
  use SetupPhoenixWeb, :controller

  alias SetupPhoenix.Accounts
  alias SetupPhoenix.Accounts.User

  action_fallback SetupPhoenixWeb.FallbackController

  def index(conn, _params) do
    with :ok <- Bodyguard.permit(SetupPhoenix.Abilities, :read_user, conn.assigns.current_user, nil)
    do
      users = Accounts.list_users()
      render(conn, "index.html", users: users)
    end
  end

  def new(conn, _params) do
    with :ok <- Bodyguard.permit(SetupPhoenix.Abilities, :write_user, conn.assigns.current_user, nil)
    do
      changeset = Accounts.change_user(%User{})
      render(conn, "new.html", changeset: changeset)
    end
  end

  def create(conn, %{"user" => user_params}) do
    with :ok <- Bodyguard.permit(SetupPhoenix.Abilities, :write_user, conn.assigns.current_user, nil)
    do
      case Accounts.create_user(user_params) do
        {:ok, user} ->
          conn
          |> put_flash(:info, "User created successfully.")
          |> redirect(to: user_path(conn, :show, user))
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with :ok <- Bodyguard.permit(SetupPhoenix.Abilities, :read_user, conn.assigns.current_user, user)
    do
      render(conn, "show.html", user: user)
    end
  end

  def edit(conn, %{"id" => id}) do
    with :ok <- Bodyguard.permit(SetupPhoenix.Abilities, :write_user, conn.assigns.current_user, nil)
    do
      user = Accounts.get_user!(id)
      changeset = Accounts.change_user(user)
      render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    with :ok <- Bodyguard.permit(SetupPhoenix.Abilities, :write_user, conn.assigns.current_user, nil)
    do
      user = Accounts.get_user!(id)

      case Accounts.update_user(user, user_params) do
        {:ok, user} ->
          conn
          |> put_flash(:info, "User updated successfully.")
          |> redirect(to: user_path(conn, :show, user))
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit.html", user: user, changeset: changeset)
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    with :ok <- Bodyguard.permit(SetupPhoenix.Abilities, :write_user, conn.assigns.current_user, nil)
    do
      user = Accounts.get_user!(id)
      {:ok, _user} = Accounts.delete_user(user)

      conn
      |> put_flash(:info, "User deleted successfully.")
      |> redirect(to: user_path(conn, :index))
    end
  end
end
