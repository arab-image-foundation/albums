defmodule AIFAlbums.Repo.Migrations.CreateAlbumSpreads do
  use Ecto.Migration

  def change do
    create table(:album_spreads) do
      add :aifid, :string
      add :height, :float
      add :width, :float
      add :inscriptions, :text

      add :album_id, references(:albums)

      timestamps()
    end

    create unique_index(:album_spreads, [:aifid])

  end
end
