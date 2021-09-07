defmodule AIFAlbums.Collections do
  @moduledoc """
  The Collections context.
  """

  import Ecto.Query, warn: false
  alias AIFAlbums.Repo

  alias AIFAlbums.Collections.Collection
  alias AIFAlbums.Albums.Album

  @doc """
  Returns the list of collections.

  ## Examples

      iex> list_collections()
      [%Collection{}, ...]

  """
  def list_collections do
    Repo.all(Collection)
  end

  def list_collections(criteria) when is_list(criteria) do
    query = from c in Collection

    Enum.reduce(criteria, query, fn
      {:sort, %{sort_by: sort_by, sort_order: sort_order}}, query ->
        from q in query, order_by: [{^sort_order, ^sort_by}]
    end)
    |> Repo.all()
  end

  @doc """
  Gets a single collection.

  Raises `Ecto.NoResultsError` if the Collection does not exist.

  ## Examples

      iex> get_collection!(123)
      %Collection{}

      iex> get_collection!(456)
      ** (Ecto.NoResultsError)

  """
  def get_collection!(id), do: Repo.get!(Collection, id)

  def get_collection_with_albums(id) do
    albums_query =
      from a in Album,
        where: a.collection_id == ^ id,
        order_by: a.aifid

    query =
      from c in Collection,
        where: c.id == ^id,
        preload: [albums: ^albums_query]

    Repo.one!(query)
  end

  @doc """
  Creates a collection.

  ## Examples

    iex> create_collection(%{field: value})
    {:ok, %Collection{}}

    iex> create_collection(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """

  def create_collection(%Collection{} = collection, attrs \\ %{}, after_save \\ &{:ok, &1}) do
    collection
    |> Collection.changeset(attrs)
    |> Repo.insert()
    |> after_save(after_save)
  end

  defp after_save({:ok, collection}, func) do
    {:ok, _post} = func.(collection)
  end
  defp after_save(error, _func), do: error

  @doc """
  Updates a collection.

  ## Examples

      iex> update_collection(collection, %{field: new_value})
      {:ok, %Collection{}}

      iex> update_collection(collection, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_collection(%Collection{} = collection, attrs, after_save \\ &{:ok, &1}) do
    IO.inspect(collection)
    IO.inspect(attrs)
    collection
    |> Collection.changeset(attrs)
    |> Repo.update()
    |> after_save(after_save)
  end

  @doc """
  Deletes a collection.

  ## Examples

      iex> delete_collection(collection)
      {:ok, %Collection{}}

      iex> delete_collection(collection)
      {:error, %Ecto.Changeset{}}

  """
  def delete_collection(%Collection{} = collection) do
    Repo.delete(collection)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking collection changes.

  ## Examples

      iex> change_collection(collection)
      %Ecto.Changeset{data: %Collection{}}

  """
  def change_collection(%Collection{} = collection, attrs \\ %{}) do
    Collection.changeset(collection, attrs)
  end
end
