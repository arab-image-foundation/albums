defmodule AIFAlbumsWeb.AdminLive.AlbumSpreadLive.FormComponent do
  use AIFAlbumsWeb, :live_component

  alias AIFAlbums.AlbumSpreads
  alias AIFAlbums.AlbumSpreads.AlbumSpread

  @impl true
  def mount(socket) do
    {
      :ok,
      socket
      |> allow_upload(
          :image,
          accept: ~w(.jpg .jpeg),
          max_file_size: 3_000_000)
    }
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
    {completed_image_uploads, []} = uploaded_entries(socket, :image)
    album_spread_params = put_image(socket, completed_image_uploads, album_spread_params)
    case AlbumSpreads.update_album_spread(
                                        socket.assigns.album_spread,
                                        album_spread_params,
                                        &consume_uploads(socket, &1)
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
    {completed_image_uploads, []} = uploaded_entries(socket, :image)
    album_spread_params = put_image(socket, completed_image_uploads, album_spread_params)
    case AlbumSpreads.create_album_spread(album_spread_params, &consume_uploads(socket, &1)) do
      {:ok, _album_spread} ->
        {:noreply,
         socket
         |> put_flash(:info, "Album spread created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp put_image(_socket, [], album_spread_params), do: album_spread_params
  defp put_image(socket, completed_image_uploads, album_spread_params) do
    urls =
      for entry <- completed_image_uploads do
        Routes.static_path(socket, "/uploads/#{entry.uuid}.jpg")
      end
    [url | _ ] = urls

    Map.merge(album_spread_params, %{"image_url" => url})
  end

  def consume_uploads(socket, %AlbumSpread{} = album) do
    consume_uploaded_entries(socket, :image, fn meta, entry ->
      dest =
        Path.join([
          :code.priv_dir(:aif_albums),
          "static",
          "uploads",
          "#{entry.uuid}.jpg"
        ])
      File.cp!(meta.path, dest)
    end)
    {:ok, album}
  end

  def error_to_string(:too_large), do: "Too large. Maximum size 30kB"
  def error_to_string(:too_many_files), do: "You have selected too many files"
  def error_to_string(:not_accepted), do: "You have selected an unacceptable file type"
end
