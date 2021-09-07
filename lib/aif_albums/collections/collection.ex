defmodule AIFAlbums.Collections.Collection do
  use Ecto.Schema
  import Ecto.Changeset

  schema "collections" do
    field :aifid, :string
    field :name, :string
    field :contract, :string
    field :credit_line, :string
    field :thumbnail_url, :string
    field :cover_image_url, :string

    has_many :albums, AIFAlbums.Albums.Album

    timestamps()
  end

  @doc false
  def changeset(collection, attrs) do
    collection
    |> cast(attrs, [:aifid, :name, :contract, :credit_line, :thumbnail_url, :cover_image_url])
    |> validate_required([:aifid, :name,])
    |> validate_required(:thumbnail_url, message: "Collection must have a thumbnail")
    |> validate_required(:cover_image_url, message: "Collection must have a cover image")
    |> unique_constraint(:aifid, message: "A collection with this number already exists")
    |> unique_constraint(:name, message: "A collection with this name already exists")
  end
end
