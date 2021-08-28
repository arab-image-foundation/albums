defmodule AIFAlbums.AlbumPages.AlbumPage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "album_pages" do
    field :aifid, :string
    field :height, :float
    field :inscriptions, :string
    field :width, :float

    belongs_to :album, AIFAlbums.Albums.Album

    timestamps()
  end

  @doc false
  def changeset(album_page, attrs) do
    album_page
    |> cast(attrs, [:aifid, :height, :width, :inscriptions, :album_id])
    |> validate_required([:aifid, :album_id])
  end
end
