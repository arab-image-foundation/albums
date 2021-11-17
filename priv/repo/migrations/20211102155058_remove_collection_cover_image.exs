defmodule AIFAlbums.Repo.Migrations.RemoveCollectionCoverImage do
  use Ecto.Migration

  def change do
    alter table(:collections) do
      remove :thumbnail_url, :string
      remove :cover_image_url, :string
    end
  end
end
