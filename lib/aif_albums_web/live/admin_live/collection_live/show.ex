defmodule AIFAlbumsWeb.AdminLive.CollectionLive.Show do
  use AIFAlbumsWeb, :live_view

  alias AIFAlbums.Collections
  alias AIFAlbums.Albums
  alias AIFAlbums.Albums.Album

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id} = params, _, socket) do
    socket =
      socket
      |> assign(:collection, Collections.get_collection_with_albums(id))
      |> apply_action(socket.assigns.live_action, params)

    {:noreply, socket}
  end

  defp apply_action(socket, :show, _params), do: socket |> assign(:page_title, "Show Collection")
  defp apply_action(socket, :edit, _params), do: socket |> assign(:page_title, "Edit Collection")
  defp apply_action(socket, :edit_album, %{"album_id" => album_id}) do
    album = Albums.get_album!(album_id)

    socket
    |> assign(:page_title, "Edit Album")
    |> assign(:album, album)
  end
  defp apply_action(socket, :new_album, _params) do
    socket
    |> assign(:page_title, "New Album")
    |> assign(:album, %Album{collection_id: socket.assigns.collection.id})
  end

  @impl true
  def handle_event("delete", %{"album-id" => album_id, "collection-id" => collection_id}, socket) do
    album = Albums.get_album!(album_id)
    {:ok, _} = Albums.delete_album(album)

    {:noreply, assign(socket, :collections, Collections.get_collection_with_albums(collection_id))}
  end
end
