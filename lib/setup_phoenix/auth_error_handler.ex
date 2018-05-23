defmodule SetupPhoenix.AuthErrorHandler do
  @moduledoc """
    Handles AuthErrors and cancels the session to redirect to the login page
  """
  import Plug.Conn

  def auth_error(conn, {_type, _reason}, _opts) do
    conn
    |> configure_session(drop: true)
    |> Phoenix.Controller.redirect(to: "/login")
    |> halt()
  end
end
