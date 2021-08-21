defmodule Albums.ArchivesTest do
  use Albums.DataCase

  alias Albums.Archives

  describe "collections" do
    alias Albums.Archives.Collection

    @valid_attrs %{aifid: "some aifid", contract: "some contract", credit_line: "some credit_line", name: "some name"}
    @update_attrs %{aifid: "some updated aifid", contract: "some updated contract", credit_line: "some updated credit_line", name: "some updated name"}
    @invalid_attrs %{aifid: nil, contract: nil, credit_line: nil, name: nil}

    def collection_fixture(attrs \\ %{}) do
      {:ok, collection} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Archives.create_collection()

      collection
    end

    test "list_collections/0 returns all collections" do
      collection = collection_fixture()
      assert Archives.list_collections() == [collection]
    end

    test "get_collection!/1 returns the collection with given id" do
      collection = collection_fixture()
      assert Archives.get_collection!(collection.id) == collection
    end

    test "create_collection/1 with valid data creates a collection" do
      assert {:ok, %Collection{} = collection} = Archives.create_collection(@valid_attrs)
      assert collection.aifid == "some aifid"
      assert collection.contract == "some contract"
      assert collection.credit_line == "some credit_line"
      assert collection.name == "some name"
    end

    test "create_collection/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Archives.create_collection(@invalid_attrs)
    end

    test "update_collection/2 with valid data updates the collection" do
      collection = collection_fixture()
      assert {:ok, %Collection{} = collection} = Archives.update_collection(collection, @update_attrs)
      assert collection.aifid == "some updated aifid"
      assert collection.contract == "some updated contract"
      assert collection.credit_line == "some updated credit_line"
      assert collection.name == "some updated name"
    end

    test "update_collection/2 with invalid data returns error changeset" do
      collection = collection_fixture()
      assert {:error, %Ecto.Changeset{}} = Archives.update_collection(collection, @invalid_attrs)
      assert collection == Archives.get_collection!(collection.id)
    end

    test "delete_collection/1 deletes the collection" do
      collection = collection_fixture()
      assert {:ok, %Collection{}} = Archives.delete_collection(collection)
      assert_raise Ecto.NoResultsError, fn -> Archives.get_collection!(collection.id) end
    end

    test "change_collection/1 returns a collection changeset" do
      collection = collection_fixture()
      assert %Ecto.Changeset{} = Archives.change_collection(collection)
    end
  end
end
