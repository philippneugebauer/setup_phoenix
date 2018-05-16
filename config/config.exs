# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :setup_phoenix,
  ecto_repos: [SetupPhoenix.Repo]

# Configures the endpoint
config :setup_phoenix, SetupPhoenixWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nvTvagzsvMm9N54+cGrrpir2qyMT9Td+00qOYGgJn7CEBDv68beOFYBB2n9GZ6+w",
  render_errors: [view: SetupPhoenixWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SetupPhoenix.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :junit_formatter,
  report_file: "test_report.xml",
  print_report_file: true

config :setup_phoenix, SetupPhoenix.Guardian,
  issuer: "setup_phoenix",
  secret_key: "aE3K7bW69gk5P0ad6CbjTNVkf6TeOKGNfr7cL7iXByVrLylBNfXd3iKaFGP4DpE6"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
