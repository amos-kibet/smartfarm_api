defmodule SmartfarmApiWeb.V1.TelemetryControllerTest do
  use SmartfarmApiWeb.ConnCase

  describe "POST /api/v1/telemetry" do
    setup do
      start_supervised!(
        {Task.Supervisor, name: SmartfarmApi.TaskSupervisor, strategy: :one_for_one}
      )

      :ok
    end

    test "accepts valid params", %{conn: conn} do
      valid_params = %{
        "data" => %{
          "air_temperature" => 18.00,
          "soil_temperature" => 22.33,
          "humidity" => 70,
          "rainfall_intensity" => 1000,
          "sunlight_intensity" => 1500,
          "soil_ph" => 5.5,
          "timestamp" => "1700988250"
        }
      }

      assert conn
             |> post("/api/v1/telemetry", valid_params)
             |> json_response(200)
    end

    test "rejects invalid params", %{conn: conn} do
      invalid_params = %{}

      assert conn
             |> post("/api/v1/telemetry", invalid_params)
             |> json_response(400)
    end
  end
end
