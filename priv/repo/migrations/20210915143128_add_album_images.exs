defmodule AIFAlbums.Repo.Migrations.AddAlbumImages do
  use Ecto.Migration

  def change do
    alter table(:albums) do
      add :thumbnail_url, :string
      add :cover_image_url, :string
    end
  end
end
