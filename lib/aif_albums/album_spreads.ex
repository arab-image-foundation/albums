defmodule AIFAlbums.AlbumSpreads do
  @moduledoc """
  The AlbumSpreads context.
  """

  import Ecto.Query, warn: false
  alias AIFAlbums.Repo

  alias AIFAlbums.AlbumSpreads.AlbumSpread

  @doc """
  Returns the list of album_spreads.

  ## Examples

      iex> list_album_spreads()
      [%AlbumSpread{}, ...]

  """
  def list_album_spreads do
    Repo.all(AlbumSpread)
  end

  @doc """
  Gets a single album_spread.

  Raises `Ecto.NoResultsError` if the Album spread does not exist.

  ## Examples

      iex> get_album_spread!(123)
      %AlbumSpread{}

      iex> get_album_spread!(456)
      ** (Ecto.NoResultsError)

  """
  def get_album_spread!(id), do: Repo.get!(AlbumSpread, id)

  def get_album_spread_with_album!(id) do
    Repo.get!(AlbumSpread, id)
    |> Repo.preload(:album)
  end

  @doc """
  Creates a album_spread.

  ## Examples

      iex> create_album_spread(%{field: value})
      {:ok, %AlbumSpread{}}

      iex> create_album_spread(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_album_spread(attrs \\ %{}, after_save \\ &{:ok, &1}) do
    %AlbumSpread{}
    |> AlbumSpread.changeset(attrs)
    |> Repo.insert()
    |> after_save(after_save)
  end

  @doc """
  Updates a album_spread.

  ## Examples

      iex> update_album_spread(album_spread, %{field: new_value})
      {:ok, %AlbumSpread{}}

      iex> update_album_spread(album_spread, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_album_spread(%AlbumSpread{} = album_spread, attrs, after_save \\ &{:ok, &1}) do
    album_spread
    |> AlbumSpread.changeset(attrs)
    |> Repo.update()
    |> after_save(after_save)
  end

  defp after_save({:ok, collection}, func) do
    {:ok, _post} = func.(collection)
  end
  defp after_save(error, _func), do: error

  @doc """
  Deletes a album_spread.

  ## Examples

      iex> delete_album_spread(album_spread)
      {:ok, %AlbumSpread{}}

      iex> delete_album_spread(album_spread)
      {:error, %Ecto.Changeset{}}

  """
  def delete_album_spread(%AlbumSpread{} = album_spread) do
    Repo.delete(album_spread)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking album_spread changes.

  ## Examples

      iex> change_album_spread(album_spread)
      %Ecto.Changeset{data: %AlbumSpread{}}

  """
  def change_album_spread(%AlbumSpread{} = album_spread, attrs \\ %{}) do
    AlbumSpread.changeset(album_spread, attrs)
  end
end
