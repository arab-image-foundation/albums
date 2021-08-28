defmodule AIFAlbumsWeb.AdminLive.AlbumPageLive.Index do
  use AIFAlbumsWeb, :live_view

  alias AIFAlbums.AlbumPages
  alias AIFAlbums.AlbumPages.AlbumPage

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :album_pages, list_album_pages())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Album page")
    |> assign(:album_page, AlbumPages.get_album_page!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Album page")
    |> assign(:album_page, %AlbumPage{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Album pages")
    |> assign(:album_page, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    album_page = AlbumPages.get_album_page!(id)
    {:ok, _} = AlbumPages.delete_album_page(album_page)

    {:noreply, assign(socket, :album_pages, list_album_pages())}
  end

  defp list_album_pages do
    AlbumPages.list_album_pages()
  end
end
