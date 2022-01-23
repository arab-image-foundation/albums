defmodule AIFAlbumsWeb.CSVLiveTest do
  use AIFAlbumsWeb.ConnCase

  import Phoenix.LiveViewTest
  import AIFAlbums.FilesFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_csv(_) do
    csv = csv_fixture()
    %{csv: csv}
  end

  describe "Index" do
    setup [:create_csv]

    test "lists all csvs", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.csv_index_path(conn, :index))

      assert html =~ "Listing Csvs"
    end

    test "saves new csv", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.csv_index_path(conn, :index))

      assert index_live |> element("a", "New Csv") |> render_click() =~
               "New Csv"

      assert_patch(index_live, Routes.csv_index_path(conn, :new))

      assert index_live
             |> form("#csv-form", csv: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#csv-form", csv: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.csv_index_path(conn, :index))

      assert html =~ "Csv created successfully"
    end

    test "updates csv in listing", %{conn: conn, csv: csv} do
      {:ok, index_live, _html} = live(conn, Routes.csv_index_path(conn, :index))

      assert index_live |> element("#csv-#{csv.id} a", "Edit") |> render_click() =~
               "Edit Csv"

      assert_patch(index_live, Routes.csv_index_path(conn, :edit, csv))

      assert index_live
             |> form("#csv-form", csv: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#csv-form", csv: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.csv_index_path(conn, :index))

      assert html =~ "Csv updated successfully"
    end

    test "deletes csv in listing", %{conn: conn, csv: csv} do
      {:ok, index_live, _html} = live(conn, Routes.csv_index_path(conn, :index))

      assert index_live |> element("#csv-#{csv.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#csv-#{csv.id}")
    end
  end

  describe "Show" do
    setup [:create_csv]

    test "displays csv", %{conn: conn, csv: csv} do
      {:ok, _show_live, html} = live(conn, Routes.csv_show_path(conn, :show, csv))

      assert html =~ "Show Csv"
    end

    test "updates csv within modal", %{conn: conn, csv: csv} do
      {:ok, show_live, _html} = live(conn, Routes.csv_show_path(conn, :show, csv))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Csv"

      assert_patch(show_live, Routes.csv_show_path(conn, :edit, csv))

      assert show_live
             |> form("#csv-form", csv: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#csv-form", csv: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.csv_show_path(conn, :show, csv))

      assert html =~ "Csv updated successfully"
    end
  end
end
