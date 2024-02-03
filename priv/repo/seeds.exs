# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SmartfarmApi.Repo.insert!(%SmartfarmApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias SmartfarmApi.Schema.Telemetry

Telemetry.changeset(%Telemetry{}, %{
  air_temperature: 23.0,
  soil_temperature: 23.0,
  humidity: 70,
  rainfall_intensity: 1500,
  sunlight_intensity: 25000,
  soil_ph: 4.5,
  timestamp: "0"
})
|> SmartfarmApi.Repo.insert!()
