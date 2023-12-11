defmodule SmartfarmApi.Repo.Migrations.CreateTelemetry do
  use Ecto.Migration

  def change do
    create table(:telemetry) do
      add :air_temperature, :float
      add :soil_temperature, :float
      add :humidity, :float
      add :rainfall_intensity, :float
      add :sunlight_intensity, :float
      add :soil_ph, :float
      add :timestamp, :string

      timestamps()
    end
  end
end
