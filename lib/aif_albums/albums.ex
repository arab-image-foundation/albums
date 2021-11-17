defmodule AIFAlbums.Albums do
  @moduledoc """
  The Albums context.
  """

  import Ecto.Query, warn: false
  alias AIFAlbums.Repo

  alias AIFAlbums.Albums.Album
  alias AIFAlbums.AlbumSpreads.AlbumSpread

  @doc """
  Returns the list of albums.

  ## Examples

      iex> list_albums()
      [%Album{}, ...]

  """
  def list_albums do
    Repo.all(Album)
  end

  def list_albums(criteria) when is_list(criteria) do
    query = from a in Album

    Enum.reduce(criteria, query, fn
      {:sort, %{sort_by: sort_by, sort_order: sort_order}}, query ->
        from q in query, order_by: [{^sort_order, ^sort_by}]
    end)
    |> Repo.all()
  end


  @doc """
  Gets a single album.

  Raises `Ecto.NoResultsError` if the Album does not exist.

  ## Examples

      iex> get_album!(123)
      %Album{}

      iex> get_album!(456)
      ** (Ecto.NoResultsError)

  """
  def get_album!(id), do: Repo.get!(Album, id)

  def get_album_with_collection(id), do: Repo.get!(Album, id) |> Repo.preload(:collection)

  def get_album_with_collection_and_spreads(id) do
    album_spreads_query =
      from s in AlbumSpread,
        where: s.album_id == ^ id,
        order_by: s.aifid

    query =
      from a in Album,
        where: a.id == ^id,
        preload: [album_spreads: ^album_spreads_query]

    Repo.one!(query) |> Repo.preload(:collection)
  end


  @doc """
  Creates a album.

  ## Examples

      iex> create_album(%{field: value})
      {:ok, %Album{}}

      iex> create_album(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_album(%Album{} = album, attrs \\ %{}, after_save \\ &{:ok, &1}) do
    album
    |> Album.changeset(attrs)
    |> Repo.insert()
    |> after_save(after_save)
  end

  defp after_save({:ok, collection}, func) do
    {:ok, _post} = func.(collection)
  end
  defp after_save(error, _func), do: error

  @doc """
  Updates a album.

  ## Examples

      iex> update_album(album, %{field: new_value})
      {:ok, %Album{}}

      iex> update_album(album, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_album(%Album{} = album, attrs, after_save \\ &{:ok, &1}) do
    album
    |> Album.changeset(attrs)
    |> Repo.update()
    |> after_save(after_save)
  end

  @doc """
  Deletes a album.

  ## Examples

      iex> delete_album(album)
      {:ok, %Album{}}

      iex> delete_album(album)
      {:error, %Ecto.Changeset{}}

  """
  def delete_album(%Album{} = album) do
    Repo.delete(album)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking album changes.

  ## Examples

      iex> change_album(album)
      %Ecto.Changeset{data: %Album{}}

  """
  def change_album(%Album{} = album, attrs \\ %{}) do
    Album.changeset(album, attrs)
  end
end
