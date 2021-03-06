defmodule AIFAlbumsWeb.AdminLive.AlbumLive.Index do
  use AIFAlbumsWeb, :live_view

  alias AIFAlbums.Albums
  alias AIFAlbums.Albums.Album

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :albums, list_albums())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Album")
    |> assign(:album, Albums.get_album!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Album")
    |> assign(:album, %Album{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Albums")
    |> assign(:album, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    album = Albums.get_album!(id)
    {:ok, _} = Albums.delete_album(album)

    {:noreply, assign(socket, :albums, list_albums())}
  end

  defp list_albums do
    Albums.list_albums()
  end
end
