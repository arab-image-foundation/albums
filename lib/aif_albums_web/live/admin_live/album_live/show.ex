defmodule AIFAlbumsWeb.AdminLive.AlbumLive.Show do
  use AIFAlbumsWeb, :live_view

  alias AIFAlbums.Albums

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:album, Albums.get_album_with_collection(id))}
  end

  defp page_title(:show), do: "Show Album"
  defp page_title(:edit), do: "Edit Album"
end