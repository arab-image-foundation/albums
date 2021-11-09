defmodule AIFAlbums.AlbumPages do
  @moduledoc """
  The AlbumPages context.
  """

  import Ecto.Query, warn: false
  alias AIFAlbums.Repo

  alias AIFAlbums.AlbumPages.AlbumPage

  @doc """
  Returns the list of album_pages.

  ## Examples

      iex> list_album_pages()
      [%AlbumPage{}, ...]

  """
  def list_album_pages do
    Repo.all(AlbumPage)
  end

  @doc """
  Gets a single album_page.

  Raises `Ecto.NoResultsError` if the Album page does not exist.

  ## Examples

      iex> get_album_page!(123)
      %AlbumPage{}

      iex> get_album_page!(456)
      ** (Ecto.NoResultsError)

  """
  def get_album_page!(id), do: Repo.get!(AlbumPage, id)

  def get_album_page_with_album!(id) do
    Repo.get!(AlbumPage, id)
    |> Repo.preload(:album)
  end

  @doc """
  Creates a album_page.

  ## Examples

      iex> create_album_page(%{field: value})
      {:ok, %AlbumPage{}}

      iex> create_album_page(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_album_page(attrs \\ %{}, after_save \\ &{:ok, &1}) do
    %AlbumPage{}
    |> AlbumPage.changeset(attrs)
    |> Repo.insert()
    |> after_save(after_save)
  end

  @doc """
  Updates a album_page.

  ## Examples

      iex> update_album_page(album_page, %{field: new_value})
      {:ok, %AlbumPage{}}

      iex> update_album_page(album_page, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_album_page(%AlbumPage{} = album_page, attrs, after_save \\ &{:ok, &1}) do
    album_page
    |> AlbumPage.changeset(attrs)
    |> Repo.update()
    |> after_save(after_save)
  end

  defp after_save({:ok, collection}, func) do
    {:ok, _post} = func.(collection)
  end
  defp after_save(error, _func), do: error

  @doc """
  Deletes a album_page.

  ## Examples

      iex> delete_album_page(album_page)
      {:ok, %AlbumPage{}}

      iex> delete_album_page(album_page)
      {:error, %Ecto.Changeset{}}

  """
  def delete_album_page(%AlbumPage{} = album_page) do
    Repo.delete(album_page)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking album_page changes.

  ## Examples

      iex> change_album_page(album_page)
      %Ecto.Changeset{data: %AlbumPage{}}

  """
  def change_album_page(%AlbumPage{} = album_page, attrs \\ %{}) do
    AlbumPage.changeset(album_page, attrs)
  end
end
