use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :setup_phoenix, SetupPhoenixWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :setup_phoenix, SetupPhoenix.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "ppn",
  password: "",
  database: "setup_phoenix_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
