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

    belongs_to :collection, AIFAlbums.Collections.Collection

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
                    :collection_id
                  ])
    |> validate_required([:aifid, :collection_id])
  end
end
