import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :smartfarm_api, SmartfarmApi.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "smartfarm_api_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :smartfarm_api, SmartfarmApiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "f3VMGp2pfzIYQk5cn01DYV6JFpBeDXX9hA5cjOBatGw0uxAvw7u2K49rrzkH9rsl",
  server: false

# In test we don't send emails.
config :smartfarm_api, SmartfarmApi.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :smartfarm_api, :websocket_token, "smartfarm"
