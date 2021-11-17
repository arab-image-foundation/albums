defmodule AIFAlbumsWeb.AdminLive.AlbumLive.FormComponent do
  use AIFAlbumsWeb, :live_component

  alias AIFAlbums.Albums
  alias AIFAlbums.Albums.Album
  alias AIFAlbums.Collections

  @impl true
  def mount(socket) do
    {
      :ok,
      socket
      |> allow_upload(
          :thumbnail,
          accept: ~w(.jpg .jpeg),
          max_file_size: 30_000)
      |> allow_upload(
          :cover_image,
          accept: ~w(.jpg .jpeg),
          max_file_size: 3_000_000)
    }
  end

  @impl true
  def update(%{album: album} = assigns, socket) do
    changeset = Albums.change_album(album)

    collections = Collections.list_collections(sort: %{sort_by: :aifid, sort_order: :asc})

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

  def handle_event("cancel-cover-image-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :cover_image, ref)}
  end

  defp save_album(socket, :edit, album_params) do
    {completed_cover_image_uploads, []} = uploaded_entries(socket, :cover_image)
    album_params = put_cover_image(socket, completed_cover_image_uploads, album_params)
    case Albums.update_album(socket.assigns.album, album_params, &consume_uploads(socket, &1)) do
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
    {completed_cover_image_uploads, []} = uploaded_entries(socket, :cover_image)
    album_params = put_cover_image(socket, completed_cover_image_uploads, album_params)
    case Albums.create_album(%Album{}, album_params, &consume_uploads(socket, &1)) do
      {:ok, _album} ->
        {:noreply,
         socket
         |> put_flash(:info, "Album created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp put_cover_image(_socket, [], album_params), do: album_params
  defp put_cover_image(socket, completed_cover_image_uploads, album_params) do
    urls =
      for entry <- completed_cover_image_uploads do
        Routes.static_path(socket, "/uploads/#{entry.uuid}.jpg")
      end
    [url | _ ] = urls

    Map.merge(album_params, %{"cover_image_url" => url})
  end

  def consume_uploads(socket, %Album{} = album) do
    consume_uploaded_entries(socket, :thumbnail, fn meta, entry ->
      thumbnail_dest =
        Path.join([
          :code.priv_dir(:aif_albums),
          "static",
          "uploads",
          "#{entry.uuid}.jpg"
        ])
      File.cp!(meta.path, thumbnail_dest)
    end)
    consume_uploaded_entries(socket, :cover_image, fn meta, entry ->
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
