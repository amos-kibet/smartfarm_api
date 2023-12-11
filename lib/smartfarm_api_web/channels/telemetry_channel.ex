defmodule SmartfarmApiWeb.Channels.TelemetryChannel do
  @moduledoc false
  use SmartfarmApiWeb, :channel

  require Logger

  alias SmartfarmApi.Query
  alias SmartfarmApi.Schema.Telemetry

  @impl true
  def join("telemetry:smartfarm", payload, socket) do
    if authorized?(payload) do
      Logger.info("Client joined \"telemetry:smartfarm\" channel.")

      socket =
        socket
        |> assign(
          telemetry: %{
            air_temperature: 0,
            soil_temperature: 0,
            humidity: 0,
            rainfall_intensity: 0,
            sunlight_intensity: 0,
            soil_ph: 0,
            timestamp: "0"
          }
        )

      send(self(), :after_join)

      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  @impl true
  def handle_info(:after_join, socket) do
    schedule_telemetry_fetch(2_000)

    {:noreply, socket}
  end

  def handle_info(:publish_latest_telemetry, socket) do
    telemetry = Query.latest_telemetry(Telemetry)

    telemetry = %{
      air_temperature: telemetry.air_temperature,
      soil_temperature: telemetry.soil_temperature,
      humidity: telemetry.humidity,
      rainfall_intensity: telemetry.rainfall_intensity,
      sunlight_intensity: telemetry.sunlight_intensity,
      soil_ph: telemetry.soil_ph,
      timestamp: telemetry.timestamp
    }

    Logger.info("Sending Telemetry: \n#{inspect(telemetry)}")

    push(socket, "telemetry", telemetry)

    schedule_telemetry_fetch(2_000)

    {:noreply, assign(socket, :telemetry, telemetry)}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

  defp schedule_telemetry_fetch(interval) do
    Process.send_after(self(), :publish_latest_telemetry, interval)
  end
end
