defmodule AIFAlbumsWeb.PageLive do
  use AIFAlbumsWeb, :live_view

  alias AIFAlbums.Collections

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(
        temporary_assign: [
          collections: []
        ]
      )
      |> assign(page_title: "AIF Albums")
      |> assign(sort_by: :aifid)
      |> assign(sort_order: :asc)

    IO.inspect(socket, label: "socket:")

    {:ok, socket}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    collections =
      list_collections(
        sort: %{sort_by: socket.assigns.sort_by, sort_order: socket.assigns.sort_order}
      )

    socket =
      socket
      |> assign(collections: collections)

    {:noreply, socket}
  end

  defp list_collections(criteria) do
    Collections.list_collections(criteria)
  end
end
