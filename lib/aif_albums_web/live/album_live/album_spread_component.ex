defmodule AIFAlbumsWeb.AlbumLive.AlbumSpreadComponent do
  use AIFAlbumsWeb, :live_component

  alias AIFAlbums.AlbumSpreads

  def mount(socket) do
    album_spreads = []
    {:ok, socket}
  end

  def update(%{
                current_album_spread: current_album_spread,
                album: album
              } = assigns, socket) do

    {
      :ok,
      socket
      |> assign(assigns)
      |> assign(:album, album)
      |> assign(:current_album_spread, current_album_spread)
    }
  end
end
