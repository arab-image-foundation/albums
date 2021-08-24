defmodule AIFAlbumsWeb.CollectionLive.Show do
  use AIFAlbumsWeb, :live_view

  alias AIFAlbums.Collections

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:collection, Collections.get_collection_with_albums(id))}
  end

  defp page_title(:show), do: "Show Collection"
  defp page_title(:edit), do: "Edit Collection"
end
