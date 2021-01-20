# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tweeter,
  ecto_repos: [Tweeter.Repo]

# Configures the endpoint
config :tweeter, TweeterWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SJZXBYd/lhcpAOmoTHXryKAYVbiQ+nlq0GgHHP+mDqTsS2dK6KFniZ8yyD7t0yY6",
  render_errors: [view: TweeterWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Tweeter.PubSub,
  live_view: [signing_salt: "dZvd7pSn"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
