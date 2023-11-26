defmodule SmartfarmApi.Context do
  alias SmartfarmApi.Repo

  @type changeset :: Ecto.Changeset.t()
  @type data :: struct()
  @type params :: map()
  @type schema :: atom()

  @spec list(schema()) :: [data()]
  def list(schema) do
    Repo.all(schema)
  end

  @spec create(schema(), params()) :: {:ok, data()} | {:error, changeset()}
  def create(schema, params) do
    schema
    |> struct!()
    |> schema.changeset(params)
    |> Repo.insert()
  end

  @spec update(schema(), params()) :: {:ok, data()} | {:error, changeset()}
  def update(schema, params) do
    schema
    |> schema.changeset(params)
    |> Repo.update()
  end
end
