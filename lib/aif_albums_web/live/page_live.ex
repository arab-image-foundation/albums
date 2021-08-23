defmodule AIFAlbumsWeb.PageLive do
  use AIFAlbumsWeb, :live_view

  alias AIFAlbums.Archives
  alias AIFAlbums.Archives.Collection

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :collections, list_collections())}
  end

  defp list_collections do
    Archives.list_collections()
  end
end
