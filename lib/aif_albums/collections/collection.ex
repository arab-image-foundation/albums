defmodule AIFAlbums.Collections.Collection do
  use Ecto.Schema
  import Ecto.Changeset

  schema "collections" do
    field :aifid, :string
    field :contract, :string
    field :credit_line, :string
    field :name, :string

    has_many :albums, AIFAlbums.Albums.Album

    timestamps()
  end

  @doc false
  def changeset(collection, attrs) do
    collection
    |> cast(attrs, [:aifid, :name, :contract, :credit_line])
    |> validate_required([:aifid, :name])
  end
end
