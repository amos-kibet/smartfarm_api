defmodule SmartfarmApiWeb.ApiHealthController do
  use SmartfarmApiWeb, :controller

  @type conn :: Plug.Conn.t()

  @spec index(conn(), map()) :: conn()
  def index(conn, _params) do
    response = Jason.encode!(%{status: "success", message: "API is running."})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, response)
  end
end
