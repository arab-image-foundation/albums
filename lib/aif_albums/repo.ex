defmodule AIFAlbums.Repo do
  use Ecto.Repo,
    otp_app: :aif_albums,
    adapter: Ecto.Adapters.Postgres
end
