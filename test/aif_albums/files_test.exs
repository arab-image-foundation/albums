defmodule AIFAlbums.FilesTest do
  use AIFAlbums.DataCase

  alias AIFAlbums.Files

  describe "csvs" do
    alias AIFAlbums.Files.CSV

    import AIFAlbums.FilesFixtures

    @invalid_attrs %{}

    test "list_csvs/0 returns all csvs" do
      csv = csv_fixture()
      assert Files.list_csvs() == [csv]
    end

    test "get_csv!/1 returns the csv with given id" do
      csv = csv_fixture()
      assert Files.get_csv!(csv.id) == csv
    end

    test "create_csv/1 with valid data creates a csv" do
      valid_attrs = %{}

      assert {:ok, %CSV{} = csv} = Files.create_csv(valid_attrs)
    end

    test "create_csv/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Files.create_csv(@invalid_attrs)
    end

    test "update_csv/2 with valid data updates the csv" do
      csv = csv_fixture()
      update_attrs = %{}

      assert {:ok, %CSV{} = csv} = Files.update_csv(csv, update_attrs)
    end

    test "update_csv/2 with invalid data returns error changeset" do
      csv = csv_fixture()
      assert {:error, %Ecto.Changeset{}} = Files.update_csv(csv, @invalid_attrs)
      assert csv == Files.get_csv!(csv.id)
    end

    test "delete_csv/1 deletes the csv" do
      csv = csv_fixture()
      assert {:ok, %CSV{}} = Files.delete_csv(csv)
      assert_raise Ecto.NoResultsError, fn -> Files.get_csv!(csv.id) end
    end

    test "change_csv/1 returns a csv changeset" do
      csv = csv_fixture()
      assert %Ecto.Changeset{} = Files.change_csv(csv)
    end
  end
end
