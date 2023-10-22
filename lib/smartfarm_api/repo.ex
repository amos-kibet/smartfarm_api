defmodule SmartfarmApi.Repo do
  use Ecto.Repo,
    otp_app: :smartfarm_api,
    adapter: Ecto.Adapters.Postgres
end
