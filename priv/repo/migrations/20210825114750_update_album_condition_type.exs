defmodule AIFAlbums.Repo.Migrations.UpdateAlbumConditionType do
  use Ecto.Migration

  def change do
    alter table(:albums) do
      modify :condition, :text
    end
  end
end
