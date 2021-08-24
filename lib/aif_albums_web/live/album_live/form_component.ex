defmodule AIFAlbumsWeb.AlbumLive.FormComponent do
  use AIFAlbumsWeb, :live_component

  alias AIFAlbums.Albums
  alias AIFAlbums.Collections

  @impl true
  def update(%{album: album} = assigns, socket) do
    changeset = Albums.change_album(album)

    collections = Collections.list_collections()

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:collections, collections)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"album" => album_params}, socket) do
    changeset =
      socket.assigns.album
      |> Albums.change_album(album_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"album" => album_params}, socket) do
    save_album(socket, socket.assigns.action, album_params)
  end

  defp save_album(socket, :edit, album_params) do
    case Albums.update_album(socket.assigns.album, album_params) do
      {:ok, _album} ->
        {:noreply,
         socket
         |> put_flash(:info, "Album updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_album(socket, :new, album_params) do
    case Albums.create_album(album_params) do
      {:ok, _album} ->
        {:noreply,
         socket
         |> put_flash(:info, "Album created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
