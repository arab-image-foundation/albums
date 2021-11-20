defmodule AIFAlbums.Repo.Migrations.AddAlbumHomepageOrder do
  use Ecto.Migration

  def change do
    alter table(:albums) do
      add :homepage_order, :integer
    end
  end
end
