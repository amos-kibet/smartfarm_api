defmodule SmartfarmApi.Schema.Telemetry do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  @fields ~w|
  air_temperature
  soil_temperature
  humidity
  rainfall_intensity
  sunlight_intensity
  soil_ph
  timestamp

  |a

  schema "telemetry" do
    field :air_temperature, :float
    field :soil_temperature, :float
    field :humidity, :float
    field :rainfall_intensity, :float
    field :sunlight_intensity, :float
    field :soil_ph, :float
    field :timestamp, :string

    timestamps()
  end

  @type t :: %__MODULE__{
          air_temperature: float,
          soil_temperature: float,
          humidity: float,
          rainfall_intensity: float,
          sunlight_intensity: float,
          soil_ph: float,
          timestamp: String
        }

  @type changeset :: Ecto.Changeset.t()

  @spec changeset(t, map) :: changeset
  def changeset(telemetry, attrs) do
    telemetry
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
