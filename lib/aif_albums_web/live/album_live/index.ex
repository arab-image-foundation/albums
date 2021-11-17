defmodule AIFAlbumsWeb.AlbumLive.Index do
  use AIFAlbumsWeb, :live_view

  alias AIFAlbums.Albums

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(
        temporary_assign: [
          albums: []
        ]
      )
      |> assign(page_title: "AIF Albums")
      |> assign(sort_by: :aifid)
      |> assign(sort_order: :asc)

    {:ok, socket}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    albums =
      list_albums(
        sort: %{sort_by: socket.assigns.sort_by, sort_order: socket.assigns.sort_order}
      )

    socket =
      socket
      |> assign(albums: albums)

    {:noreply, socket}
  end

  defp list_albums(criteria) do
    Albums.list_albums(criteria)
  end
end
