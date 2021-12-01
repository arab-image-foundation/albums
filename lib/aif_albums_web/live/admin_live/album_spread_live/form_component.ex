defmodule AIFAlbumsWeb.AdminLive.AlbumSpreadLive.FormComponent do
  use AIFAlbumsWeb, :live_component

  alias AIFAlbums.AlbumSpreads
  alias AIFAlbums.AlbumSpreads.AlbumSpread

  @impl true
  def mount(socket) do
    { :ok, socket }
  end

  @impl true
  def update(%{album_spread: album_spread} = assigns, socket) do
    changeset = AlbumSpreads.change_album_spread(album_spread)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"album_spread" => album_spread_params}, socket) do
    changeset =
      socket.assigns.album_spread
      |> AlbumSpreads.change_album_spread(album_spread_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"album_spread" => album_spread_params}, socket) do
    save_album_spread(socket, socket.assigns.action, album_spread_params)
  end

  defp save_album_spread(socket, :edit, album_spread_params) do
    case AlbumSpreads.update_album_spread(
                                        socket.assigns.album_spread,
                                        album_spread_params
                                      ) do
      {:ok, _album_spread} ->
        {:noreply,
         socket
         |> put_flash(:info, "Album spread updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_album_spread(socket, :new, album_spread_params) do
    case AlbumSpreads.create_album_spread(album_spread_params) do
      {:ok, _album_spread} ->
        {:noreply,
         socket
         |> put_flash(:info, "Album spread created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
