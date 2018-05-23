defmodule SetupPhoenix.Plug.CurrentUserPlug do
  @moduledoc """
    Assigns the current resource to each connection, in this case the logged in user
  """
  def init(opts), do: opts

  def call(conn, _opts) do
    current_user = Guardian.Plug.current_resource(conn) || nil
    Plug.Conn.assign(conn, :current_user, current_user)
  end
end
