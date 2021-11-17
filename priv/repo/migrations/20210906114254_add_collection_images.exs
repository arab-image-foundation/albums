defmodule AIFAlbums.Repo.Migrations.AddCollectionImages do
  use Ecto.Migration

  def change do
    alter table(:collections) do
      add :thumbnail_url, :string
      add :cover_image_url, :string
    end
  end
end
