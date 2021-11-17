defmodule AIFAlbums.AlbumsTest do
  use AIFAlbums.DataCase

  alias AIFAlbums.Albums

  describe "albums" do
    alias AIFAlbums.Albums.Album

    @valid_attrs %{aifid: "some aifid", city: "some city", condition: "some condition", date: ~D[2010-04-17], depth: 120.5, description: "some description", height: 120.5, inscriptions: "some inscriptions", photographer: "some photographer", width: 120.5}
    @update_attrs %{aifid: "some updated aifid", city: "some updated city", condition: "some updated condition", date: ~D[2011-05-18], depth: 456.7, description: "some updated description", height: 456.7, inscriptions: "some updated inscriptions", photographer: "some updated photographer", width: 456.7}
    @invalid_attrs %{aifid: nil, city: nil, condition: nil, date: nil, depth: nil, description: nil, height: nil, inscriptions: nil, photographer: nil, width: nil}

    def album_fixture(attrs \\ %{}) do
      {:ok, album} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Albums.create_album()

      album
    end

    test "list_albums/0 returns all albums" do
      album = album_fixture()
      assert Albums.list_albums() == [album]
    end

    test "get_album!/1 returns the album with given id" do
      album = album_fixture()
      assert Albums.get_album!(album.id) == album
    end

    test "create_album/1 with valid data creates a album" do
      assert {:ok, %Album{} = album} = Albums.create_album(@valid_attrs)
      assert album.aifid == "some aifid"
      assert album.city == "some city"
      assert album.condition == "some condition"
      assert album.date == ~D[2010-04-17]
      assert album.depth == 120.5
      assert album.description == "some description"
      assert album.height == 120.5
      assert album.inscriptions == "some inscriptions"
      assert album.photographer == "some photographer"
      assert album.width == 120.5
    end

    test "create_album/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Albums.create_album(@invalid_attrs)
    end

    test "update_album/2 with valid data updates the album" do
      album = album_fixture()
      assert {:ok, %Album{} = album} = Albums.update_album(album, @update_attrs)
      assert album.aifid == "some updated aifid"
      assert album.city == "some updated city"
      assert album.condition == "some updated condition"
      assert album.date == ~D[2011-05-18]
      assert album.depth == 456.7
      assert album.description == "some updated description"
      assert album.height == 456.7
      assert album.inscriptions == "some updated inscriptions"
      assert album.photographer == "some updated photographer"
      assert album.width == 456.7
    end

    test "update_album/2 with invalid data returns error changeset" do
      album = album_fixture()
      assert {:error, %Ecto.Changeset{}} = Albums.update_album(album, @invalid_attrs)
      assert album == Albums.get_album!(album.id)
    end

    test "delete_album/1 deletes the album" do
      album = album_fixture()
      assert {:ok, %Album{}} = Albums.delete_album(album)
      assert_raise Ecto.NoResultsError, fn -> Albums.get_album!(album.id) end
    end

    test "change_album/1 returns a album changeset" do
      album = album_fixture()
      assert %Ecto.Changeset{} = Albums.change_album(album)
    end
  end
end
