defmodule AlbumsWeb.PageLive do
  use AlbumsWeb, :live_view

  alias Albums.Archives
  alias Albums.Archives.Collection

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :collections, list_collections())}
  end

  defp list_collections do
    Archives.list_collections()
  end
end
