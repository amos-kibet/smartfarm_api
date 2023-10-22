defmodule SmartfarmApiWeb.Channels.TelemetryChannel do
  @moduledoc false
  use SmartfarmApiWeb, :channel

  require Logger

  @impl true
  def join("telemetry:smartfarm", payload, socket) do
    if authorized?(payload) do
      Logger.info("Client joined \"telemetry:smartfarm\" channel")

      with {:ok, pid} <- start_mqtt_broker(),
           {:ok, _, _} <-
             :emqtt.subscribe(pid, "sensors/#") do
        send(self(), :after_join)

        {_, seconds_timestamp, _} = :os.timestamp()

        socket =
          socket
          |> assign(
            mqtt_client_pid: pid,
            telemetry: %{
              air_temperature: 0,
              soil_temperature: 0,
              humidity: 0,
              rainfall: 0,
              timestamp: seconds_timestamp
            }
          )

        {:ok, socket}
      end
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  @impl true
  def handle_info(:after_join, socket) do
    telemetry = socket.assigns[:telemetry]

    push(socket, "telemetry", telemetry)

    Logger.info("Server sent telemetry: #{inspect(telemetry)}")

    {:noreply, socket}
  end

  @impl true
  def handle_info({:publish, packet}, socket) do
    {:ok, telemetry} = get_telemetry(parse_topic(packet), packet)

    air_temperature_telemetry = telemetry["temperature"]
    soil_temperature_telemetry = telemetry["temperature"]
    humidity_telemetry = telemetry["humidity"]
    rainfall_telemetry = telemetry["rainfall"] || 0

    {_, seconds_timestamp, _} = :os.timestamp()

    socket =
      socket
      |> assign(:telemetry, %{
        air_temperature: air_temperature_telemetry,
        soil_temperature: soil_temperature_telemetry,
        humidity: humidity_telemetry,
        rainfall: rainfall_telemetry
      })

    # Send data to WebSocket clients
    push(
      socket,
      "telemetry",
      %{
        air_temperature: air_temperature_telemetry,
        soil_temperature: soil_temperature_telemetry,
        humidity: humidity_telemetry,
        rainfall: rainfall_telemetry,
        timestamp: seconds_timestamp
      }
    )

    Logger.info("Server sent telemetry: #{inspect(telemetry)}")

    {:noreply, socket}
  end

  defp start_mqtt_broker do
    emqtt_opts =
      Application.get_env(:smartfarm_api, :emqtt)

    with {:ok, pid} <- :emqtt.start_link(emqtt_opts),
         {:ok, _} = :emqtt.connect(pid) do
      {:ok, pid}
    end
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

  defp get_telemetry(["sensors", "smartfarm"], %{payload: payload}) do
    {:ok, _telemetry} = Jason.decode(payload)
  end

  defp parse_topic(%{topic: topic}) do
    String.split(topic, "/", trim: true)
  end
end
