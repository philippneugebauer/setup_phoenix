defmodule SetupPhoenixWeb.FallbackController do
  use SetupPhoenixWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_flash(:error, gettext("The page does not exist!"))
    |> handle_redirect()
    |> halt()
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_flash(:error, gettext("You must not access that page!"))
    |> handle_redirect()
    |> halt()
  end

  defp handle_redirect(conn) do
    case conn.assigns.current_user do
      nil -> redirect(conn, to: "/login")
      _ -> redirect(conn, to: "/")
    end
  end

end
