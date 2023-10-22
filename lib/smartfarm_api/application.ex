defmodule SmartfarmApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SmartfarmApiWeb.Telemetry,
      # Start the Ecto repository
      SmartfarmApi.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: SmartfarmApi.PubSub},
      # Start Finch
      {Finch, name: SmartfarmApi.Finch},
      # Start the Endpoint (http/https)
      SmartfarmApiWeb.Endpoint
      # Start a worker by calling: SmartfarmApi.Worker.start_link(arg)
      # {SmartfarmApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SmartfarmApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SmartfarmApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
