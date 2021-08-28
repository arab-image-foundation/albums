defmodule AIFAlbumsWeb.AlbumPageLiveTest do
  use AIFAlbumsWeb.ConnCase

  import Phoenix.LiveViewTest

  alias AIFAlbums.AlbumPages

  @create_attrs %{aifid: "some aifid", height: 120.5, inscriptions: "some inscriptions", width: 120.5}
  @update_attrs %{aifid: "some updated aifid", height: 456.7, inscriptions: "some updated inscriptions", width: 456.7}
  @invalid_attrs %{aifid: nil, height: nil, inscriptions: nil, width: nil}

  defp fixture(:album_page) do
    {:ok, album_page} = AlbumPages.create_album_page(@create_attrs)
    album_page
  end

  defp create_album_page(_) do
    album_page = fixture(:album_page)
    %{album_page: album_page}
  end

  describe "Index" do
    setup [:create_album_page]

    test "lists all album_pages", %{conn: conn, album_page: album_page} do
      {:ok, _index_live, html} = live(conn, Routes.album_page_index_path(conn, :index))

      assert html =~ "Listing Album pages"
      assert html =~ album_page.aifid
    end

    test "saves new album_page", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.album_page_index_path(conn, :index))

      assert index_live |> element("a", "New Album page") |> render_click() =~
               "New Album page"

      assert_patch(index_live, Routes.album_page_index_path(conn, :new))

      assert index_live
             |> form("#album_page-form", album_page: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#album_page-form", album_page: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.album_page_index_path(conn, :index))

      assert html =~ "Album page created successfully"
      assert html =~ "some aifid"
    end

    test "updates album_page in listing", %{conn: conn, album_page: album_page} do
      {:ok, index_live, _html} = live(conn, Routes.album_page_index_path(conn, :index))

      assert index_live |> element("#album_page-#{album_page.id} a", "Edit") |> render_click() =~
               "Edit Album page"

      assert_patch(index_live, Routes.album_page_index_path(conn, :edit, album_page))

      assert index_live
             |> form("#album_page-form", album_page: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#album_page-form", album_page: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.album_page_index_path(conn, :index))

      assert html =~ "Album page updated successfully"
      assert html =~ "some updated aifid"
    end

    test "deletes album_page in listing", %{conn: conn, album_page: album_page} do
      {:ok, index_live, _html} = live(conn, Routes.album_page_index_path(conn, :index))

      assert index_live |> element("#album_page-#{album_page.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#album_page-#{album_page.id}")
    end
  end

  describe "Show" do
    setup [:create_album_page]

    test "displays album_page", %{conn: conn, album_page: album_page} do
      {:ok, _show_live, html} = live(conn, Routes.album_page_show_path(conn, :show, album_page))

      assert html =~ "Show Album page"
      assert html =~ album_page.aifid
    end

    test "updates album_page within modal", %{conn: conn, album_page: album_page} do
      {:ok, show_live, _html} = live(conn, Routes.album_page_show_path(conn, :show, album_page))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Album page"

      assert_patch(show_live, Routes.album_page_show_path(conn, :edit, album_page))

      assert show_live
             |> form("#album_page-form", album_page: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#album_page-form", album_page: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.album_page_show_path(conn, :show, album_page))

      assert html =~ "Album page updated successfully"
      assert html =~ "some updated aifid"
    end
  end
end
