defmodule AIFAlbums.AlbumSpreads.AlbumSpread do
  use Ecto.Schema
  import Ecto.Changeset

  schema "album_spreads" do
    field :aifid, :string
    field :height, :float
    field :inscriptions, :string
    field :width, :float
    field :image_url, :string

    belongs_to :album, AIFAlbums.Albums.Album

    timestamps()
  end

  @doc false
  def changeset(album_spread, attrs) do
    album_spread
    |> cast(attrs, [:aifid, :height, :width, :inscriptions, :album_id])
    |> validate_required([:aifid, :album_id])
    |> unique_constraint(:aifid, message: "An album spread with this number already exists")
  end
end
