defmodule AIFAlbums.Repo.Migrations.CreateCsvs do
  use Ecto.Migration

  def change do
    create table(:csvs) do
      add :rows, {:array, :map}, null: false, default: []

      timestamps()
    end
  end
end
