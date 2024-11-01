import Config

# Configures Swoosh API Client
config :swoosh, api_client: Swoosh.ApiClient.Finch, finch_name: SmartfarmApi.Finch

# Disable Swoosh Local Memory Storage
config :swoosh, local: false

# Do not print debug messages in production
config :logger, level: :info

config :smartfarm_api, :websocket_token, "smartfarm"

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.
