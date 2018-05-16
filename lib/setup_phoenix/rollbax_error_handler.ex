defmodule SetupPhoenix.RollbaxErrorHandler do
  use Plug.ErrorHandler

  defp handle_errors(conn, %{kind: kind, reason: reason, stack: stacktrace}) do
    conn =
      conn
      |> Plug.Conn.fetch_cookies()
      |> Plug.Conn.fetch_query_params()

    params =
      case conn.params do
        %Plug.Conn.Unfetched{aspect: :params} -> "unfetched"
        other -> other
      end

    occurrence_data = %{
      "request" => %{
        "cookies" => conn.req_cookies,
        "url" => "#{conn.scheme}://#{conn.host}:#{conn.port}#{conn.request_path}",
        "user_ip" => List.to_string(:inet.ntoa(conn.remote_ip)),
        "headers" => Enum.into(conn.req_headers, %{}),
        "method" => conn.method,
        "params" => params,
      },
      "server" => %{
        "pid" => System.get_env("MY_SERVER_PID"),
        "host" => "#{System.get_env("MY_HOSTNAME")}:#{System.get_env("MY_PORT")}",
        "root" => System.get_env("MY_APPLICATION_PATH"),
      },
    }

    Rollbax.report(kind, reason, stacktrace, _custom_data = %{}, occurrence_data)
  end
end