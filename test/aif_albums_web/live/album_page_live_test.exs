defmodule AIFAlbumsWeb.AlbumSpreadLiveTest do
  use AIFAlbumsWeb.ConnCase

  import Phoenix.LiveViewTest

  alias AIFAlbums.AlbumSpreads

  @create_attrs %{aifid: "some aifid", height: 120.5, inscriptions: "some inscriptions", width: 120.5}
  @update_attrs %{aifid: "some updated aifid", height: 456.7, inscriptions: "some updated inscriptions", width: 456.7}
  @invalid_attrs %{aifid: nil, height: nil, inscriptions: nil, width: nil}

  defp fixture(:album_spread) do
    {:ok, album_spread} = AlbumSpreads.create_album_spread(@create_attrs)
    album_spread
  end

  defp create_album_spread(_) do
    album_spread = fixture(:album_spread)
    %{album_spread: album_spread}
  end

  describe "Index" do
    setup [:create_album_spread]

    test "lists all album_spreads", %{conn: conn, album_spread: album_spread} do
      {:ok, _index_live, html} = live(conn, Routes.album_spread_index_path(conn, :index))

      assert html =~ "Listing Album spreads"
      assert html =~ album_spread.aifid
    end

    test "saves new album_spread", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.album_spread_index_path(conn, :index))

      assert index_live |> element("a", "New Album spread") |> render_click() =~
               "New Album spread"

      assert_patch(index_live, Routes.album_spread_index_path(conn, :new))

      assert index_live
             |> form("#album_spread-form", album_spread: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#album_spread-form", album_spread: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.album_spread_index_path(conn, :index))

      assert html =~ "Album spread created successfully"
      assert html =~ "some aifid"
    end

    test "updates album_spread in listing", %{conn: conn, album_spread: album_spread} do
      {:ok, index_live, _html} = live(conn, Routes.album_spread_index_path(conn, :index))

      assert index_live |> element("#album_spread-#{album_spread.id} a", "Edit") |> render_click() =~
               "Edit Album spread"

      assert_patch(index_live, Routes.album_spread_index_path(conn, :edit, album_spread))

      assert index_live
             |> form("#album_spread-form", album_spread: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#album_spread-form", album_spread: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.album_spread_index_path(conn, :index))

      assert html =~ "Album spread updated successfully"
      assert html =~ "some updated aifid"
    end

    test "deletes album_spread in listing", %{conn: conn, album_spread: album_spread} do
      {:ok, index_live, _html} = live(conn, Routes.album_spread_index_path(conn, :index))

      assert index_live |> element("#album_spread-#{album_spread.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#album_spread-#{album_spread.id}")
    end
  end

  describe "Show" do
    setup [:create_album_spread]

    test "displays album_spread", %{conn: conn, album_spread: album_spread} do
      {:ok, _show_live, html} = live(conn, Routes.album_spread_show_path(conn, :show, album_spread))

      assert html =~ "Show Album spread"
      assert html =~ album_spread.aifid
    end

    test "updates album_spread within modal", %{conn: conn, album_spread: album_spread} do
      {:ok, show_live, _html} = live(conn, Routes.album_spread_show_path(conn, :show, album_spread))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Album spread"

      assert_patch(show_live, Routes.album_spread_show_path(conn, :edit, album_spread))

      assert show_live
             |> form("#album_spread-form", album_spread: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#album_spread-form", album_spread: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.album_spread_show_path(conn, :show, album_spread))

      assert html =~ "Album spread updated successfully"
      assert html =~ "some updated aifid"
    end
  end
end
