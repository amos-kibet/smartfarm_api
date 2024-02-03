defmodule SmartfarmApiWeb.WebSockets.TelemetrySocket do
  @moduledoc false
  use Phoenix.Socket

  require Logger

  @type conn :: Plug.Conn.t()
  @type socket :: Phoenix.Socket.t()

  channel "telemetry:*", SmartfarmApiWeb.Channels.TelemetryChannel

  @impl true
  @spec connect(map(), socket, map()) :: {:ok, socket} | {:error, :connection_error}
  def connect(params, socket, _connect_info) do
    if authorized?(params["token"]) do
      Logger.info("Connected to Smartfarm API WebSocket.")

      {:ok, socket}
    else
      Logger.error("Failed to connect to Smartfarm API WebSocket.")

      {:error, :connection_error}
    end
  end

  @impl true
  @spec id(socket) :: nil
  def id(_socket), do: nil

  defp authorized?(_client_token) do
    # token = Application.get_env(:smartfarm_api, :websocket_token)

    # if client_token == token, do: true, else: false

    true
  end

  @spec handle_error(conn, :connection_error) :: conn
  def handle_error(conn, :connection_error) do
    Logger.error("WebSocket connection error handled.")

    Plug.Conn.send_resp(conn, 403, "Invalid token")
  end
end
