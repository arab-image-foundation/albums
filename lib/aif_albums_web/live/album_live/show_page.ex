defmodule AIFAlbumsWeb.AlbumLive.ShowPage do
  use AIFAlbumsWeb, :live_view

  alias AIFAlbums.Albums

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"album_id" => album_id, "page_id" => page_id}, _, socket) do
    album = Albums.get_album_with_collection_and_pages(album_id)
    current_album_page =
      case page_id do
        "cover" ->
          List.first(album.album_pages)
        _ ->
          Enum.find(album.album_pages, &(&1.id == String.to_integer(page_id)))
      end

    {:noreply,
     socket
     |> assign(:album, album)
     |> assign(:current_album_page, current_album_page)
     |> assign(:page_title, "Album Page")
    }
  end
end
