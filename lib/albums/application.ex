defmodule Albums.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Albums.Repo,
      # Start the Telemetry supervisor
      AlbumsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Albums.PubSub},
      # Start the Endpoint (http/https)
      AlbumsWeb.Endpoint
      # Start a worker by calling: Albums.Worker.start_link(arg)
      # {Albums.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Albums.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    AlbumsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
