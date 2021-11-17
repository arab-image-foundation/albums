defmodule AIFAlbums.Repo.Migrations.CreateAlbums do
  use Ecto.Migration

  def change do
    create table(:albums) do
      add :aifid, :string, null: false
      add :description, :text
      add :height, :float
      add :width, :float
      add :depth, :float
      add :condition, :string
      add :inscriptions, :text
      add :photographer, :string
      add :date, :date
      add :city, :string

      add :collection_id, references(:collections)

      timestamps()
    end

    create unique_index(:albums, [:aifid])

  end
end
