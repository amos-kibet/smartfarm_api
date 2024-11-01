# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :smartfarm_api,
  ecto_repos: [SmartfarmApi.Repo]

# Configures the endpoint
config :smartfarm_api, SmartfarmApiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: SmartfarmApiWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: SmartfarmApi.PubSub,
  live_view: [signing_salt: "avO1gXvz"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :smartfarm_api, SmartfarmApi.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :smartfarm_api, :env, Mix.env()

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
