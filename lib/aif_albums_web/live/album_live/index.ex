defmodule AIFAlbumsWeb.AlbumLive.Index do
  use AIFAlbumsWeb, :live_view

  alias AIFAlbums.Albums

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :albums, list_albums())}
  end

  defp list_albums do
    Albums.list_albums()
  end
end
