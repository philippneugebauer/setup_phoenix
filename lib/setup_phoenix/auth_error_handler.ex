defmodule SetupPhoenix.AuthErrorHandler do
  import Plug.Conn

  def auth_error(conn, {_type, _reason}, _opts) do
    conn
    |> configure_session(drop: true)
    |> Phoenix.Controller.redirect(to: "/login")
    |> halt()
  end
end
