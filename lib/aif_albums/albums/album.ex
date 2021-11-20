defmodule AIFAlbums.Albums.Album do
  use Ecto.Schema
  import Ecto.Changeset

  schema "albums" do
    field :aifid, :string
    field :city, :string
    field :condition, :string
    field :date, :date
    field :depth, :float
    field :description, :string
    field :height, :float
    field :inscriptions, :string
    field :photographer, :string
    field :width, :float
    field :thumbnail_url, :string
    field :cover_image_url, :string
    field :homepage_order, :integer


    belongs_to :collection, AIFAlbums.Collections.Collection

    has_many :album_spreads, AIFAlbums.AlbumSpreads.AlbumSpread

    timestamps()
  end

  @doc false
  def changeset(album, attrs) do
    album
    |> cast(attrs, [
                    :aifid,
                    :description,
                    :height,
                    :width,
                    :depth,
                    :condition,
                    :inscriptions,
                    :photographer,
                    :date,
                    :city,
                    :collection_id,
                    :thumbnail_url,
                    :cover_image_url,
                    :homepage_order
                  ])
    |> validate_required([:aifid, :collection_id, :homepage_order])
    |> validate_required(:cover_image_url, message: "Collection must have a cover image")
    |> unique_constraint(:aifid, message: "An album with this number already exists")
  end
end
