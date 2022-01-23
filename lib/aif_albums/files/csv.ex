defmodule AIFAlbums.Files.CSV do
  use Ecto.Schema
  import Ecto.Changeset

  schema "csvs" do
    field :rows, {:array, :map}

    timestamps()
  end

  @doc false
  def changeset(csv, attrs) do
    csv
    |> cast(attrs, [:rows])
    |> validate_required([:rows])
  end
end
