defmodule AIFAlbums.Repo.Migrations.RemoveAlbumImageFields do
  use Ecto.Migration

  def change do
    alter table(:albums) do
      remove :thumbnail_url, :string
      remove :cover_image_url, :string
    end
  end
end
