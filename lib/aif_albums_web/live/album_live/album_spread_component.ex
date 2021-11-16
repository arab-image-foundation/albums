defmodule AIFAlbumsWeb.AlbumLive.AlbumSpreadComponent do
  use AIFAlbumsWeb, :live_component

  alias AIFAlbums.AlbumPages

  def mount(socket) do
    {:ok, socket}
  end

  def update(%{
                current_album_page: current_album_page,
                album: album
              } = assigns, socket) do

    {
      :ok,
      socket
      |> assign(assigns)
      |> assign(:album, album)
      |> assign(:current_album_page, current_album_page)
    }
  end
end
