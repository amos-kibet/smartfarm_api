defmodule SmartfarmApiWeb.Router do
  use SmartfarmApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SmartfarmApiWeb do
    pipe_through :api
    get "/health", ApiHealthController, :index
  end

  # Enable Swoosh mailbox preview in development
  if Application.compile_env(:smartfarm_api, :dev_routes) do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
