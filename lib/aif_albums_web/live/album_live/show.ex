defmodule AIFAlbumsWeb.AlbumLive.Show do
  use AIFAlbumsWeb, :live_view

  alias AIFAlbums.Albums

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    album = Albums.get_album_with_collection(id)

    {:noreply,
     socket
     |> assign(:page_title, "Album #{album.aifid}")
     |> assign(:album, album)}
  end
end
