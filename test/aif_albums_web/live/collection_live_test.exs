defmodule AIFAlbumsWeb.CollectionLiveTest do
  use AIFAlbumsWeb.ConnCase

  import Phoenix.LiveViewTest

  alias AIFAlbums.Collections

  @create_attrs %{aifid: "some aifid", contract: "some contract", credit_line: "some credit_line", name: "some name"}
  @update_attrs %{aifid: "some updated aifid", contract: "some updated contract", credit_line: "some updated credit_line", name: "some updated name"}
  @invalid_attrs %{aifid: nil, contract: nil, credit_line: nil, name: nil}

  defp fixture(:collection) do
    {:ok, collection} = Collections.create_collection(@create_attrs)
    collection
  end

  defp create_collection(_) do
    collection = fixture(:collection)
    %{collection: collection}
  end

  describe "Index" do
    setup [:create_collection]

    test "lists all collections", %{conn: conn, collection: collection} do
      {:ok, _index_live, html} = live(conn, Routes.collection_index_path(conn, :index))

      assert html =~ "Listing Collections"
      assert html =~ collection.aifid
    end

    test "saves new collection", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.collection_index_path(conn, :index))

      assert index_live |> element("a", "New Collection") |> render_click() =~
               "New Collection"

      assert_patch(index_live, Routes.collection_index_path(conn, :new))

      assert index_live
             |> form("#collection-form", collection: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#collection-form", collection: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.collection_index_path(conn, :index))

      assert html =~ "Collection created successfully"
      assert html =~ "some aifid"
    end

    test "updates collection in listing", %{conn: conn, collection: collection} do
      {:ok, index_live, _html} = live(conn, Routes.collection_index_path(conn, :index))

      assert index_live |> element("#collection-#{collection.id} a", "Edit") |> render_click() =~
               "Edit Collection"

      assert_patch(index_live, Routes.collection_index_path(conn, :edit, collection))

      assert index_live
             |> form("#collection-form", collection: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#collection-form", collection: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.collection_index_path(conn, :index))

      assert html =~ "Collection updated successfully"
      assert html =~ "some updated aifid"
    end

    test "deletes collection in listing", %{conn: conn, collection: collection} do
      {:ok, index_live, _html} = live(conn, Routes.collection_index_path(conn, :index))

      assert index_live |> element("#collection-#{collection.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#collection-#{collection.id}")
    end
  end

  describe "Show" do
    setup [:create_collection]

    test "displays collection", %{conn: conn, collection: collection} do
      {:ok, _show_live, html} = live(conn, Routes.collection_show_path(conn, :show, collection))

      assert html =~ "Show Collection"
      assert html =~ collection.aifid
    end

    test "updates collection within modal", %{conn: conn, collection: collection} do
      {:ok, show_live, _html} = live(conn, Routes.collection_show_path(conn, :show, collection))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Collection"

      assert_patch(show_live, Routes.collection_show_path(conn, :edit, collection))

      assert show_live
             |> form("#collection-form", collection: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#collection-form", collection: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.collection_show_path(conn, :show, collection))

      assert html =~ "Collection updated successfully"
      assert html =~ "some updated aifid"
    end
  end
end
