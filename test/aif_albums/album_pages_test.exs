defmodule AIFAlbums.AlbumSpreadsTest do
  use AIFAlbums.DataCase

  alias AIFAlbums.AlbumSpreads

  describe "album_spreads" do
    alias AIFAlbums.AlbumSpreads.AlbumSpread

    @valid_attrs %{aifid: "some aifid", height: 120.5, inscriptions: "some inscriptions", width: 120.5}
    @update_attrs %{aifid: "some updated aifid", height: 456.7, inscriptions: "some updated inscriptions", width: 456.7}
    @invalid_attrs %{aifid: nil, height: nil, inscriptions: nil, width: nil}

    def album_spread_fixture(attrs \\ %{}) do
      {:ok, album_spread} =
        attrs
        |> Enum.into(@valid_attrs)
        |> AlbumSpreads.create_album_spread()

      album_spread
    end

    test "list_album_spreads/0 returns all album_spreads" do
      album_spread = album_spread_fixture()
      assert AlbumSpreads.list_album_spreads() == [album_spread]
    end

    test "get_album_spread!/1 returns the album_spread with given id" do
      album_spread = album_spread_fixture()
      assert AlbumSpreads.get_album_spread!(album_spread.id) == album_spread
    end

    test "create_album_spread/1 with valid data creates a album_spread" do
      assert {:ok, %AlbumSpread{} = album_spread} = AlbumSpreads.create_album_spread(@valid_attrs)
      assert album_spread.aifid == "some aifid"
      assert album_spread.height == 120.5
      assert album_spread.inscriptions == "some inscriptions"
      assert album_spread.width == 120.5
    end

    test "create_album_spread/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AlbumSpreads.create_album_spread(@invalid_attrs)
    end

    test "update_album_spread/2 with valid data updates the album_spread" do
      album_spread = album_spread_fixture()
      assert {:ok, %AlbumSpread{} = album_spread} = AlbumSpreads.update_album_spread(album_spread, @update_attrs)
      assert album_spread.aifid == "some updated aifid"
      assert album_spread.height == 456.7
      assert album_spread.inscriptions == "some updated inscriptions"
      assert album_spread.width == 456.7
    end

    test "update_album_spread/2 with invalid data returns error changeset" do
      album_spread = album_spread_fixture()
      assert {:error, %Ecto.Changeset{}} = AlbumSpreads.update_album_spread(album_spread, @invalid_attrs)
      assert album_spread == AlbumSpreads.get_album_spread!(album_spread.id)
    end

    test "delete_album_spread/1 deletes the album_spread" do
      album_spread = album_spread_fixture()
      assert {:ok, %AlbumSpread{}} = AlbumSpreads.delete_album_spread(album_spread)
      assert_raise Ecto.NoResultsError, fn -> AlbumSpreads.get_album_spread!(album_spread.id) end
    end

    test "change_album_spread/1 returns a album_spread changeset" do
      album_spread = album_spread_fixture()
      assert %Ecto.Changeset{} = AlbumSpreads.change_album_spread(album_spread)
    end
  end
end
