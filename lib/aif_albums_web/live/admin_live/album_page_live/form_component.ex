defmodule AIFAlbumsWeb.AdminLive.AlbumPageLive.FormComponent do
  use AIFAlbumsWeb, :live_component

  alias AIFAlbums.AlbumPages

  @impl true
  def update(%{album_page: album_page} = assigns, socket) do
    changeset = AlbumPages.change_album_page(album_page)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"album_page" => album_page_params}, socket) do
    changeset =
      socket.assigns.album_page
      |> AlbumPages.change_album_page(album_page_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"album_page" => album_page_params}, socket) do
    save_album_page(socket, socket.assigns.action, album_page_params)
  end

  defp save_album_page(socket, :edit, album_page_params) do
    case AlbumPages.update_album_page(socket.assigns.album_page, album_page_params) do
      {:ok, _album_page} ->
        {:noreply,
         socket
         |> put_flash(:info, "Album page updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_album_page(socket, :new, album_page_params) do
    case AlbumPages.create_album_page(album_page_params) do
      {:ok, _album_page} ->
        {:noreply,
         socket
         |> put_flash(:info, "Album page created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
