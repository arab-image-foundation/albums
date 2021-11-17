defmodule AIFAlbumsWeb.AdminLive.AlbumLive.Show do
  use AIFAlbumsWeb, :live_view

  alias AIFAlbums.Albums
  alias AIFAlbums.AlbumSpreads
  alias AIFAlbums.AlbumSpreads.AlbumSpread

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id} = params, _, socket) do
    socket =
      socket
      |> assign(:album, Albums.get_album_with_collection_and_spreads(id))
      |> apply_action(socket.assigns.live_action, params)

    {:noreply, socket}
  end

  defp apply_action(socket, :show, _params), do: socket |> assign(:page_title, "Show Album")
  defp apply_action(socket, :edit, _params), do: socket |> assign(:page_title, "Edit Album")
  defp apply_action(socket, :edit_album_spread, %{"spread_id" => spread_id}) do
    album_spread = AlbumSpreads.get_album_spread!(spread_id)

    socket
    |> assign(:page_title, "Edit Spread")
    |> assign(:album_spread, album_spread)
  end
  defp apply_action(socket, :new_album_spread, _params) do
    socket
    |> assign(:page_title, "New Spread for Album #{socket.assigns.album.aifid}")
    |> assign(:album_spread, %AlbumSpread{album_id: socket.assigns.album.id})
  end

  @impl true
  def handle_event("delete", %{"album-spread-id" => album_spread_id, "album-id" => album_id}, socket) do
    album_spread = AlbumSpreads.get_album_spread!(album_spread_id)
    {:ok, _} = AlbumSpreads.delete_album_spread(album_spread)

    {:noreply, assign(socket, :album, Albums.get_album_with_collection_and_spreads(album_id))}
  end
end
