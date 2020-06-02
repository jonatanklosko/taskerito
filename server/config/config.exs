# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :taskerito,
  ecto_repos: [Taskerito.Repo]

# Configures the endpoint
config :taskerito, TaskeritoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gXW1pxypqOT7rkZKq3+B1hVZpjzdxH3GjeyauOM4eyzcfksucE1rEn7YAFPjzxeb",
  render_errors: [view: TaskeritoWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Taskerito.PubSub,
  live_view: [signing_salt: "ndJOho+x"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
