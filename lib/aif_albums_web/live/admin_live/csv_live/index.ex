defmodule AIFAlbumsWeb.AdminLive.CSVLive.Index do
  use AIFAlbumsWeb, :live_view

  alias AIFAlbums.Files
  alias AIFAlbums.Files.CSV

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :csvs, list_csvs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Csv")
    |> assign(:csv, Files.get_csv!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Csv")
    |> assign(:csv, %CSV{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Csvs")
    |> assign(:csv, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    csv = Files.get_csv!(id)
    {:ok, _} = Files.delete_csv(csv)

    {:noreply, assign(socket, :csvs, list_csvs())}
  end

  defp list_csvs do
    Files.list_csvs()
  end
end
