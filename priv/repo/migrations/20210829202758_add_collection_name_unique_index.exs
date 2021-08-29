defmodule AIFAlbums.Repo.Migrations.AddCollectionNameUniqueIndex do
  use Ecto.Migration

  def change do
    create unique_index("collections", [:name])
  end
end
