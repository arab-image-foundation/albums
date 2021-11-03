defmodule AIFAlbums.Repo.Migrations.AddPageImage do
  use Ecto.Migration

  def change do
    alter table(:album_pages) do
      add :image_url, :string
    end
  end
end
