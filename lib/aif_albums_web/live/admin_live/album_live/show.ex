defmodule AIFAlbumsWeb.AdminLive.AlbumLive.Show do
  use AIFAlbumsWeb, :live_view

  alias AIFAlbums.Albums
  alias AIFAlbums.AlbumPages.AlbumPage

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id} = params, _, socket) do
    socket =
      socket
      |> assign(:album, Albums.get_album_with_collection_and_pages(id))
      |> apply_action(socket.assigns.live_action, params)

    {:noreply, socket}
  end

  defp apply_action(socket, :show, _params), do: socket |> assign(:page_title, "Show Album")
  defp apply_action(socket, :edit, _params), do: socket |> assign(:page_title, "Edit Album")
  # defp apply_action(socket, :edit_album_page, %{"page_id" => page_id}) do
  #   album_page = AlbumPages.get_album_page!(page_id)

  #   socket
  #   |> assign(:page_title, "Edit Page")
  #   |> assign(:album_page, album_page)
  # end
  defp apply_action(socket, :new_album_page, _params) do
    socket
    |> assign(:page_title, "New Page for Album #{socket.assigns.album.aifid}")
    |> assign(:album_page, %AlbumPage{album_id: socket.assigns.album.id})
  end


end
