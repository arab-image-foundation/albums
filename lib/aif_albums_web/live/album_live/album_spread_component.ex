defmodule AIFAlbumsWeb.AlbumLive.AlbumSpreadComponent do
  use AIFAlbumsWeb, :live_component

  alias Phoenix.LiveView.JS

  alias AIFAlbums.AlbumSpreads

  def mount(socket) do
    {:ok, socket}
  end

  # def update(%{
  #               album_spread: album_spread,
  #               album: album
  #             } = assigns, socket) do

  #   {
  #     :ok,
  #     socket
  #     |> assign(assigns)
  #     |> assign(:album, album)
  #     |> assign(:album_spread, album_spread)
  #   }
  # end

  def hide_image(js \\ %JS{}) do
    js
    |> JS.hide(transition: "fade-out", to: "#spread-image")
  end
end
