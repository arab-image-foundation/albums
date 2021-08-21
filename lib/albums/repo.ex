defmodule Albums.Repo do
  use Ecto.Repo,
    otp_app: :albums,
    adapter: Ecto.Adapters.Postgres
end
