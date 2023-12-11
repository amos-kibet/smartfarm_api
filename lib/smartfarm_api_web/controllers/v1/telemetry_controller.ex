defmodule SmartfarmApiWeb.V1.TelemetryController do
  use SmartfarmApiWeb, :controller

  alias SmartfarmApi.Context
  alias SmartfarmApi.Schema.Telemetry

  @type conn :: Plug.Conn.t()

  @spec create(conn(), map()) :: conn()
  def create(conn, %{"telemetry" => data} = _params) do
    case validate_data(data) do
      {:ok, data} ->
        Task.Supervisor.async_nolink(SmartfarmApi.TaskSupervisor, fn ->
          Context.create(Telemetry, data)
        end)

        conn
        |> put_resp_content_type("application/json")
        |> send_resp(
          200,
          Jason.encode!(%{status: "success", message: "Telemetry received successfully!"})
        )

      {:error, message} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(400, Jason.encode!(%{status: "error", message: message}))
    end
  end

  def create(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(400, Jason.encode!(%{status: "error", message: "Invalid data format."}))
  end

  defp validate_data(data) do
    case data do
      %{
        "air_temperature" => _,
        "soil_temperature" => _,
        "humidity" => _,
        "rainfall_intensity" => _,
        "sunlight_intensity" => _,
        "soil_ph" => _,
        "timestamp" => _
      } ->
        {:ok, data}

      _ ->
        {:error, "Invalid data format."}
    end
  end
end
