defmodule AIFAlbumsWeb.AlbumPageLive.Show do
  use AIFAlbumsWeb, :live_view

  alias AIFAlbums.AlbumPages

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    album_page = AlbumPages.get_album_page!(id)

    {:noreply,
     socket
     |> assign(:page_title, album_page.aifid)
     |> assign(:album_page, album_page)}
  end
end
