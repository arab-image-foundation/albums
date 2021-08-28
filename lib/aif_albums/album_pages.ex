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

  @doc """
  Creates a album_page.

  ## Examples

      iex> create_album_page(%{field: value})
      {:ok, %AlbumPage{}}

      iex> create_album_page(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_album_page(attrs \\ %{}) do
    %AlbumPage{}
    |> AlbumPage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a album_page.

  ## Examples

      iex> update_album_page(album_page, %{field: new_value})
      {:ok, %AlbumPage{}}

      iex> update_album_page(album_page, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_album_page(%AlbumPage{} = album_page, attrs) do
    album_page
    |> AlbumPage.changeset(attrs)
    |> Repo.update()
  end

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
