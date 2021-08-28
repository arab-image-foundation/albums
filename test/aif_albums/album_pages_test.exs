defmodule AIFAlbums.AlbumPagesTest do
  use AIFAlbums.DataCase

  alias AIFAlbums.AlbumPages

  describe "album_pages" do
    alias AIFAlbums.AlbumPages.AlbumPage

    @valid_attrs %{aifid: "some aifid", height: 120.5, inscriptions: "some inscriptions", width: 120.5}
    @update_attrs %{aifid: "some updated aifid", height: 456.7, inscriptions: "some updated inscriptions", width: 456.7}
    @invalid_attrs %{aifid: nil, height: nil, inscriptions: nil, width: nil}

    def album_page_fixture(attrs \\ %{}) do
      {:ok, album_page} =
        attrs
        |> Enum.into(@valid_attrs)
        |> AlbumPages.create_album_page()

      album_page
    end

    test "list_album_pages/0 returns all album_pages" do
      album_page = album_page_fixture()
      assert AlbumPages.list_album_pages() == [album_page]
    end

    test "get_album_page!/1 returns the album_page with given id" do
      album_page = album_page_fixture()
      assert AlbumPages.get_album_page!(album_page.id) == album_page
    end

    test "create_album_page/1 with valid data creates a album_page" do
      assert {:ok, %AlbumPage{} = album_page} = AlbumPages.create_album_page(@valid_attrs)
      assert album_page.aifid == "some aifid"
      assert album_page.height == 120.5
      assert album_page.inscriptions == "some inscriptions"
      assert album_page.width == 120.5
    end

    test "create_album_page/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AlbumPages.create_album_page(@invalid_attrs)
    end

    test "update_album_page/2 with valid data updates the album_page" do
      album_page = album_page_fixture()
      assert {:ok, %AlbumPage{} = album_page} = AlbumPages.update_album_page(album_page, @update_attrs)
      assert album_page.aifid == "some updated aifid"
      assert album_page.height == 456.7
      assert album_page.inscriptions == "some updated inscriptions"
      assert album_page.width == 456.7
    end

    test "update_album_page/2 with invalid data returns error changeset" do
      album_page = album_page_fixture()
      assert {:error, %Ecto.Changeset{}} = AlbumPages.update_album_page(album_page, @invalid_attrs)
      assert album_page == AlbumPages.get_album_page!(album_page.id)
    end

    test "delete_album_page/1 deletes the album_page" do
      album_page = album_page_fixture()
      assert {:ok, %AlbumPage{}} = AlbumPages.delete_album_page(album_page)
      assert_raise Ecto.NoResultsError, fn -> AlbumPages.get_album_page!(album_page.id) end
    end

    test "change_album_page/1 returns a album_page changeset" do
      album_page = album_page_fixture()
      assert %Ecto.Changeset{} = AlbumPages.change_album_page(album_page)
    end
  end
end
