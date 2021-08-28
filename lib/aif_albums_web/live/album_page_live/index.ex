defmodule AIFAlbumsWeb.AlbumPageLive.Index do
  use AIFAlbumsWeb, :live_view

  alias AIFAlbums.AlbumPages

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :album_pages, list_album_pages())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Album pages")
    |> assign(:album_page, nil)
  end

  defp list_album_pages do
    AlbumPages.list_album_pages()
  end
end
