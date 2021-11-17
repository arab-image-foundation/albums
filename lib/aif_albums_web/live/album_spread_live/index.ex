defmodule AIFAlbumsWeb.AlbumSpreadLive.Index do
  use AIFAlbumsWeb, :live_view

  alias AIFAlbums.AlbumSpreads

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :album_spreads, list_album_spreads())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Album pages")
    |> assign(:album_spread, nil)
  end

  defp list_album_spreads do
    AlbumSpreads.list_album_spreads()
  end
end
