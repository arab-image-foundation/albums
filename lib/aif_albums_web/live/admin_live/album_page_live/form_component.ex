defmodule AIFAlbumsWeb.AdminLive.AlbumPageLive.FormComponent do
  use AIFAlbumsWeb, :live_component

  alias AIFAlbums.AlbumPages
  alias AIFAlbums.AlbumPages.AlbumPage

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
    {completed_image_uploads, []} = uploaded_entries(socket, :image)
    album_page_params = put_image(socket, completed_image_uploads, album_page_params)
    case AlbumPages.update_album_page(
                                        socket.assigns.album_page,
                                        album_page_params,
                                        &consume_uploads(socket, &1)
                                      ) do
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
    {completed_image_uploads, []} = uploaded_entries(socket, :image)
    album_page_params = put_image(socket, completed_image_uploads, album_page_params)
    case AlbumPages.create_album_page(album_page_params, &consume_uploads(socket, &1)) do
      {:ok, _album_page} ->
        {:noreply,
         socket
         |> put_flash(:info, "Album page created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp put_image(_socket, [], album_page_params), do: album_page_params
  defp put_image(socket, completed_image_uploads, album_page_params) do
    urls =
      for entry <- completed_image_uploads do
        Routes.static_path(socket, "/uploads/#{entry.uuid}.jpg")
      end
    [url | _ ] = urls

    Map.merge(album_page_params, %{"image_url" => url})
  end

  def consume_uploads(socket, %AlbumPage{} = album) do
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
