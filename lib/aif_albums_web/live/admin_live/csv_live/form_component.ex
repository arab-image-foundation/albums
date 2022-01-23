defmodule AIFAlbumsWeb.AdminLive.CSVLive.FormComponent do
  use AIFAlbumsWeb, :live_component

  alias AIFAlbums.Files
  alias AIFAlbums.AlbumSpreads

  @impl true
  def update(%{csv: csv} = assigns, socket) do
    changeset = Files.change_csv(csv)

    {:ok,
     socket
     |> assign(assigns)
     |> allow_upload(:csv_file, accept: ~w(.csv))
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", _csv_params, socket) do
    {:noreply, socket}
  end

  def handle_event("save", csv_params, socket) do
    save_csv(socket, socket.assigns.action, csv_params)
  end

  defp save_csv(socket, :edit, csv_params) do
    [result|_] =
      consume_uploaded_entries(socket, :csv_file, fn %{path: path}, _entry ->
        path
        |> File.stream!()
        |> CSV.decode!(headers: true)
        |> Enum.each(&AlbumSpreads.import_spread/1)
      end)

    case result do
      {:ok, _csv} ->
        {:noreply,
         socket
         |> put_flash(:info, "CSV uploaded successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_csv(socket, :new, csv_params) do
    [result|_] =
      consume_uploaded_entries(socket, :csv_file, fn %{path: path}, _entry ->
        path
        |> File.stream!()
        |> CSV.decode!(headers: true)
        |> Enum.each(&AlbumSpreads.import_spread/1)
      end)

    case result do
      :ok ->
        {:noreply,
         socket
         |> put_flash(:info, "CSV uploaded successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
