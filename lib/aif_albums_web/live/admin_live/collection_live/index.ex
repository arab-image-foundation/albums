defmodule AIFAlbumsWeb.AdminLive.CollectionLive.Index do
  use AIFAlbumsWeb, :live_view

  alias AIFAlbums.Collections
  alias AIFAlbums.Collections.Collection

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :collections, list_collections(sort: %{sort_by: :aifid, sort_order: :asc}))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Collection")
    |> assign(:collection, Collections.get_collection!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Collection")
    |> assign(:collection, %Collection{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Collections")
    |> assign(:collection, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    collection = Collections.get_collection!(id)
    {:ok, _} = Collections.delete_collection(collection)

    {:noreply, assign(socket, :collections, list_collections(sort: %{sort_by: :aifid, sort_order: :asc}))}
  end

  defp list_collections(criteria) do
    Collections.list_collections(criteria)
  end
end
