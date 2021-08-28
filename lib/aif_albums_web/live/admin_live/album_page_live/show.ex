defmodule AIFAlbumsWeb.AdminLive.AlbumPageLive.Show do
  use AIFAlbumsWeb, :live_view

  alias AIFAlbums.AlbumPages

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:album_page, AlbumPages.get_album_page!(id))}
  end

  defp page_title(:show), do: "Show Album page"
  defp page_title(:edit), do: "Edit Album page"
end
