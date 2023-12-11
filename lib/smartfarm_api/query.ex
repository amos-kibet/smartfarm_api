defmodule SmartfarmApi.Query do
  import Ecto.Query

  alias SmartfarmApi.Repo

  @type schema :: Ecto.Queryable.t()
  @type data :: Ecto.Schema.t()

  @spec latest_telemetry(schema()) :: data()
  def latest_telemetry(schema) do
    from(t in schema)
    |> last(:updated_at)
    |> Repo.one()
  end
end
