defmodule AIFAlbumsWeb.Router do
  use AIFAlbumsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {AIFAlbumsWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AIFAlbumsWeb do
    pipe_through :browser

    live "/", PageLive, :index

    live "/collections/:id", CollectionLive.Show, :show

    live "/albums", AlbumLive.Index, :index
    live "/albums/:id", AlbumLive.Show, :show
    live "/albums/:album_id/browse/:page_id", AlbumLive.ShowPage, :show

    live "/admin", AdminLive.Index, :index

    live "/admin/collections", AdminLive.CollectionLive.Index, :index
    live "/admin/collections/new", AdminLive.CollectionLive.Index, :new
    live "/admin/collections/:id", AdminLive.CollectionLive.Show, :show
    live "/admin/collections/:id/edit", AdminLive.CollectionLive.Index, :edit
    live "/admin/collections/:id/show/edit", AdminLive.CollectionLive.Show, :edit
    live "/admin/collections/:id/album/:album_id/edit", AdminLive.CollectionLive.Show, :edit_album
    live "/admin/collections/:id/album/new", AdminLive.CollectionLive.Show, :new_album

    # live "/admin/albums", AdminLive.AlbumLive.Index, :index
    # live "/admin/albums/new", AdminLive.AlbumLive.Index, :new
    live "/admin/albums/:id", AdminLive.AlbumLive.Show, :show
    # live "/admin/albums/:id/edit", AdminLive.AlbumLive.Index, :edit
    live "/admin/albums/:id/show/edit", AdminLive.AlbumLive.Show, :edit
    live "/admin/albums/:id/page/new", AdminLive.AlbumLive.Show, :new_album_page

    # live "/admin/album_pages/new", AdminLive.AlbumPageLive.Index, :new
    # live "/admin/album_pages/:id/edit", AdminLive.AlbumPageLive.Index, :edit

    live "/admin/album_pages/:id", AdminLive.AlbumPageLive.Show, :show
    # live "/admin/album_pages/:id/show/edit", AdminLive.AlbumPageLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", AIFAlbumsWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: AIFAlbumsWeb.Telemetry
    end
  end
end
