defmodule AIFAlbums.Files do
  @moduledoc """
  The Files context.
  """

  import Ecto.Query, warn: false
  alias AIFAlbums.Repo

  alias AIFAlbums.Files.CSV

  @doc """
  Returns the list of csvs.

  ## Examples

      iex> list_csvs()
      [%CSV{}, ...]

  """
  def list_csvs do
    Repo.all(CSV)
  end

  @doc """
  Gets a single csv.

  Raises `Ecto.NoResultsError` if the Csv does not exist.

  ## Examples

      iex> get_csv!(123)
      %CSV{}

      iex> get_csv!(456)
      ** (Ecto.NoResultsError)

  """
  def get_csv!(id), do: Repo.get!(CSV, id)

  @doc """
  Creates a csv.

  ## Examples

      iex> create_csv(%{field: value})
      {:ok, %CSV{}}

      iex> create_csv(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_csv(attrs \\ %{}) do
    %CSV{}
    |> CSV.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a csv.

  ## Examples

      iex> update_csv(csv, %{field: new_value})
      {:ok, %CSV{}}

      iex> update_csv(csv, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_csv(%CSV{} = csv, attrs) do
    csv
    |> CSV.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a csv.

  ## Examples

      iex> delete_csv(csv)
      {:ok, %CSV{}}

      iex> delete_csv(csv)
      {:error, %Ecto.Changeset{}}

  """
  def delete_csv(%CSV{} = csv) do
    Repo.delete(csv)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking csv changes.

  ## Examples

      iex> change_csv(csv)
      %Ecto.Changeset{data: %CSV{}}

  """
  def change_csv(%CSV{} = csv, attrs \\ %{}) do
    CSV.changeset(csv, attrs)
  end
end
