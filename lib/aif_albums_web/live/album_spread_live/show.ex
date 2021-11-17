defmodule AIFAlbumsWeb.AlbumSpreadLive.Show do
  use AIFAlbumsWeb, :live_view

  alias AIFAlbums.AlbumSpreads

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    album_spread = AlbumSpreads.get_album_spread!(id)

    {:noreply,
     socket
     |> assign(:page_title, album_spread.aifid)
     |> assign(:album_spread, album_spread)}
  end
end
