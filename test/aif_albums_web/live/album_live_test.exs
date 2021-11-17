defmodule AIFAlbumsWeb.AlbumLiveTest do
  use AIFAlbumsWeb.ConnCase

  import Phoenix.LiveViewTest

  alias AIFAlbums.Albums

  @create_attrs %{aifid: "some aifid", city: "some city", condition: "some condition", date: ~D[2010-04-17], depth: 120.5, description: "some description", height: 120.5, inscriptions: "some inscriptions", photographer: "some photographer", width: 120.5}
  @update_attrs %{aifid: "some updated aifid", city: "some updated city", condition: "some updated condition", date: ~D[2011-05-18], depth: 456.7, description: "some updated description", height: 456.7, inscriptions: "some updated inscriptions", photographer: "some updated photographer", width: 456.7}
  @invalid_attrs %{aifid: nil, city: nil, condition: nil, date: nil, depth: nil, description: nil, height: nil, inscriptions: nil, photographer: nil, width: nil}

  defp fixture(:album) do
    {:ok, album} = Albums.create_album(@create_attrs)
    album
  end

  defp create_album(_) do
    album = fixture(:album)
    %{album: album}
  end

  describe "Index" do
    setup [:create_album]

    test "lists all albums", %{conn: conn, album: album} do
      {:ok, _index_live, html} = live(conn, Routes.album_index_path(conn, :index))

      assert html =~ "Listing Albums"
      assert html =~ album.aifid
    end

    test "saves new album", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.album_index_path(conn, :index))

      assert index_live |> element("a", "New Album") |> render_click() =~
               "New Album"

      assert_patch(index_live, Routes.album_index_path(conn, :new))

      assert index_live
             |> form("#album-form", album: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#album-form", album: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.album_index_path(conn, :index))

      assert html =~ "Album created successfully"
      assert html =~ "some aifid"
    end

    test "updates album in listing", %{conn: conn, album: album} do
      {:ok, index_live, _html} = live(conn, Routes.album_index_path(conn, :index))

      assert index_live |> element("#album-#{album.id} a", "Edit") |> render_click() =~
               "Edit Album"

      assert_patch(index_live, Routes.album_index_path(conn, :edit, album))

      assert index_live
             |> form("#album-form", album: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#album-form", album: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.album_index_path(conn, :index))

      assert html =~ "Album updated successfully"
      assert html =~ "some updated aifid"
    end

    test "deletes album in listing", %{conn: conn, album: album} do
      {:ok, index_live, _html} = live(conn, Routes.album_index_path(conn, :index))

      assert index_live |> element("#album-#{album.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#album-#{album.id}")
    end
  end

  describe "Show" do
    setup [:create_album]

    test "displays album", %{conn: conn, album: album} do
      {:ok, _show_live, html} = live(conn, Routes.album_show_path(conn, :show, album))

      assert html =~ "Show Album"
      assert html =~ album.aifid
    end

    test "updates album within modal", %{conn: conn, album: album} do
      {:ok, show_live, _html} = live(conn, Routes.album_show_path(conn, :show, album))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Album"

      assert_patch(show_live, Routes.album_show_path(conn, :edit, album))

      assert show_live
             |> form("#album-form", album: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#album-form", album: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.album_show_path(conn, :show, album))

      assert html =~ "Album updated successfully"
      assert html =~ "some updated aifid"
    end
  end
end
