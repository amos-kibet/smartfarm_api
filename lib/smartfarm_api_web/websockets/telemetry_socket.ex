defmodule SmartfarmApiWeb.WebSockets.TelemetrySocket do
  @moduledoc false
  use Phoenix.Socket

  require Logger

  channel "telemetry:*", SmartfarmApiWeb.Channels.TelemetryChannel

  @impl true
  def connect(_params, socket, _connect_info) do
    Logger.info("Connected to Smartfarm API WebSocket.")

    {:ok, socket}
  end

  @impl true
  def id(_socket), do: nil
end
