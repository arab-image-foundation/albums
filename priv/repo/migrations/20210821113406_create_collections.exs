defmodule AIFAlbums.Repo.Migrations.CreateCollections do
  use Ecto.Migration

  def change do
    create table(:collections) do
      add :aifid, :string, null: false
      add :name, :string, null: false
      add :contract, :string
      add :credit_line, :text

      timestamps()
    end

    create index(:collections, [:aifid, :name])
    create unique_index("collections", [:aifid])
  end
end
