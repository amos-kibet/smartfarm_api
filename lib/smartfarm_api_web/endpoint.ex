defmodule SmartfarmApiWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :smartfarm_api

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_smartfarm_api_key",
    signing_salt: "Izwww6Cr",
    same_site: "Lax"
  ]

  # socket "/live", Phoenix.LiveView.Socket, websocket: [connect_info: [session: @session_options]]

  socket "/socket", SmartfarmApiWeb.WebSockets.TelemetrySocket,
    websocket: [
      check_origin: [
        "http://localhost:3001",
        "http://127.0.0.1:3001",
        "http://localhost:3000",
        "http://127.0.0.1:3000"
      ],
      error_handler: {SmartfarmApiWeb.WebSockets.TelemetrySocket, :handle_error, []},
      fullsweep_after: 0
    ],
    longpoll: false

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :smartfarm_api,
    gzip: false,
    only: SmartfarmApiWeb.static_paths()

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :smartfarm_api
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug SmartfarmApiWeb.Router
end
