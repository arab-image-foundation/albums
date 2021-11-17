defmodule AIFAlbumsWeb.AlbumLive.ShowSpread do
  use AIFAlbumsWeb, :live_view

  alias AIFAlbumsWeb.AlbumLive.AlbumSpreadComponent
  alias AIFAlbums.AlbumSpreads.AlbumSpread
  alias AIFAlbums.Albums

  @impl true
  def mount(_params, _session, socket) do
    socket
    |> assign(
      temporary_assign: [
        album_spreads_list: []
      ])
    |> assign(page_title: "Album")

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"album_id" => album_id, "spread_id" => spread_id}, _, socket) do
    album = Albums.get_album_with_collection_and_spreads(album_id)

    album_spreads_list = Enum.map(album.album_spreads, fn %AlbumSpread{id: id} -> id end)

    current_album_spread =
      case spread_id do
        "cover" ->
          List.first(album.album_spreads)
        _ ->
          Enum.find(album.album_spreads, &(&1.id == String.to_integer(spread_id)))
      end

    previous_spread_id = get_previous_spread_id(current_album_spread.id, album_spreads_list)
    next_spread_id = get_next_spread_id(current_album_spread.id, album_spreads_list)

    {:noreply,
     socket
     |> assign(:album, album)
     |> assign(:previous_spread_id, previous_spread_id)
     |> assign(:next_spread_id, next_spread_id)
     |> assign(:current_album_spread, current_album_spread)
     |> assign(:page_title, "Album Page")
    }
  end

  defp get_previous_spread_id(spread_id, [first_spread | _] = album_spreads_list) do
    cond do
      spread_id == first_spread -> nil
      true ->
        Enum.at(album_spreads_list, Enum.find_index(album_spreads_list, &(&1 == spread_id)) - 1)
    end
  end

  defp get_next_spread_id(spread_id, [_ | last_spread] = album_spreads_list) do
    cond do
      spread_id == last_spread -> nil
      true ->
        Enum.at(album_spreads_list, Enum.find_index(album_spreads_list, &(&1 == spread_id)) + 1)
    end
  end
end
