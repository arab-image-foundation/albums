defmodule AIFAlbumsWeb.AdminLive.CollectionLive.FormComponent do
  use AIFAlbumsWeb, :live_component

  alias AIFAlbums.Collections
  alias AIFAlbums.Collections.Collection

  @impl true
  def mount(socket) do
    {
      :ok,
      allow_upload(socket,
        :thumbnail,
        accept: ~w(.jpg .jpeg),
        max_file_size: 30_000)
    }
  end

  @impl true
  def update(%{collection: collection} = assigns, socket) do
    changeset = Collections.change_collection(collection)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"collection" => collection_params}, socket) do
    changeset =
      socket.assigns.collection
      |> Collections.change_collection(collection_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"collection" => collection_params}, socket) do
    save_collection(socket, socket.assigns.action, collection_params)
  end

  def handle_event("cancel-thumbnail-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :thumbnail, ref)}
  end

  defp save_collection(socket, :edit, collection_params) do
    collection_params = put_thumbnail(socket, collection_params)
    case Collections.update_collection(socket.assigns.collection, collection_params, &consume_thumbnail(socket, &1)) do
      {:ok, _collection} ->
        {:noreply,
         socket
         |> put_flash(:info, "Collection updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_collection(socket, :new, collection_params) do
    collection = put_thumbnail(socket, %Collection{})
    case Collections.create_collection(collection, collection_params, &consume_thumbnail(socket, &1)) do
      {:ok, _collection} ->
        {:noreply,
         socket
         |> put_flash(:info, "Collection created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp put_thumbnail(socket, collection_params) do
    {completed, []} = uploaded_entries(socket, :thumbnail)

    IO.inspect(uploaded_entries(socket, :thumbnail))
    urls =
      for entry <- completed do
        Routes.static_path(socket, "/uploads/#{entry.uuid}.jpg")
      end
    [url | _ ] = urls

    Map.merge(collection_params, %{"thumbnail_url" => url})
  end

  def consume_thumbnail(socket, %Collection{} = collection) do
    consume_uploaded_entries(socket, :thumbnail, fn meta, entry ->
      dest =
        Path.join([
          :code.priv_dir(:aif_albums),
          "static",
          "uploads",
          "#{entry.uuid}.jpg"
        ])
      File.cp!(meta.path, dest)
    end)
    {:ok, collection}
  end

  def error_to_string(:too_large), do: "Too large. Maximum size 30kB"
  def error_to_string(:too_many_files), do: "You have selected too many files"
  def error_to_string(:not_accepted), do: "You have selected an unacceptable file type"
end
