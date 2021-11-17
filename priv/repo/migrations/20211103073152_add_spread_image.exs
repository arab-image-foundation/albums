defmodule AIFAlbums.Repo.Migrations.AddSpreadImage do
  use Ecto.Migration

  def change do
    alter table(:album_spreads) do
      add :image_url, :string
    end
  end
end
