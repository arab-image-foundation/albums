defmodule AIFAlbumsWeb.AdminLive.AlbumSpreadLive.Show do
  use AIFAlbumsWeb, :live_view

  alias AIFAlbums.Albums
  alias AIFAlbums.AlbumSpreads

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    album_spread = AlbumSpreads.get_album_spread_with_album!(id)
    album = Albums.get_album_with_collection(album_spread.album.id)

    {
      :noreply,
      socket
      |> assign(:page_title, page_title(socket.assigns.live_action))
      |> assign(album_spread: album_spread)
      |> assign(album: album)
    }
  end

  defp page_title(:show), do: "Show Album page"
  defp page_title(:edit), do: "Edit Album page"
end
