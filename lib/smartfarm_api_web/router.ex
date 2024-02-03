defmodule SmartfarmApiWeb.Router do
  use SmartfarmApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SmartfarmApiWeb do
    pipe_through :api
    get "/", ApiHealthController, :index
  end

  scope "/api/v1", SmartfarmApiWeb do
    pipe_through :api
    post "/telemetry", V1.TelemetryController, :create
  end

  # Enable Swoosh mailbox preview in development
  if Application.compile_env(:smartfarm_api, :dev_routes) do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
