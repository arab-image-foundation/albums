import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :aif_albums, AIFAlbums.Repo,
  username: "postgres",
  password: "postgres",
  database: "aif_albums_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :aif_albums, AIFAlbumsWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "eidj0IMNYrtRbF1r+TM5Wv2r4DqkvWIvsYno6BGKojBE4lY/WhNy1RGeXiOIYk83",
  server: false

# config :aif_albums, uploads_path: Path.join([:code.priv_dir(:aif_albums),
#   "static", "test_uploads"])

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
