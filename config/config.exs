# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :aif_albums,
  namespace: AIFAlbums,
  ecto_repos: [AIFAlbums.Repo]

# Configures the endpoint
config :aif_albums, AIFAlbumsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "C4xk6XGQtKygjRKlsaDcK5PDgTlj7zeM3vPCN8sFa1aYtWITONSrIDxF5Vx5av/9",
  render_errors: [view: AIFAlbumsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: AIFAlbums.PubSub,
  live_view: [signing_salt: "0tXUWlX/"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
