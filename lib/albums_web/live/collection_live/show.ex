defmodule AlbumsWeb.CollectionLive.Show do
  use AlbumsWeb, :live_view

  alias Albums.Archives

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:collection, Archives.get_collection!(id))}
  end

  defp page_title(:show), do: "Show Collection"
  defp page_title(:edit), do: "Edit Collection"
end
