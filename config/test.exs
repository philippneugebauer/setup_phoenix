use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :setup_phoenix, SetupPhoenixWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :junit_formatter,
  report_file: "test_report.xml",
  print_report_file: true

# Configure your database
config :setup_phoenix, SetupPhoenix.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("DB_USER") || "ppn",
  password: System.get_env("DB_PW") || "",
  database: "setup_phoenix_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
