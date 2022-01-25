defmodule AIFAlbumsWeb.Router do
  use AIFAlbumsWeb, :router

  import AIFAlbumsWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {AIFAlbumsWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
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

  ## Authentication routes

  scope "/", AIFAlbumsWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", AIFAlbumsWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email

    live "/admin", AdminLive.Index, :index

    live "/admin/collections", AdminLive.CollectionLive.Index, :index
    live "/admin/collections/new", AdminLive.CollectionLive.Index, :new
    live "/admin/collections/:id", AdminLive.CollectionLive.Show, :show
    live "/admin/collections/:id/edit", AdminLive.CollectionLive.Index, :edit
    live "/admin/collections/:id/show/edit", AdminLive.CollectionLive.Show, :edit
    live "/admin/collections/:id/album/:album_id/edit", AdminLive.CollectionLive.Show, :edit_album
    live "/admin/collections/:id/album/new", AdminLive.CollectionLive.Show, :new_album

    # live "/admin/albums", AdminLive.AlbumLive.Index, :index
    live "/admin/albums/new", AdminLive.AlbumLive.Index, :new
    live "/admin/albums/:id", AdminLive.AlbumLive.Show, :show
    # live "/admin/albums/:id/edit", AdminLive.AlbumLive.Index, :edit
    live "/admin/albums/:id/show/edit", AdminLive.AlbumLive.Show, :edit
    live "/admin/albums/:id/spread/new", AdminLive.AlbumLive.Show, :new_album_spread
    live "/admin/albums/:id/spread/:spread_id/edit", AdminLive.AlbumLive.Show, :edit_album_spread

    # live "/admin/album_spreads/new", AdminLive.AlbumSpreadLive.Index, :new
    # live "/admin/album_spreads/:id/edit", AdminLive.AlbumSpreadLive.Index, :edit

    live "/admin/album_spreads/:id", AdminLive.AlbumSpreadLive.Show, :show
    # live "/admin/album_spreads/:id/show/edit", AdminLive.AlbumSpreadLive.Show, :edit

    live "/admin/csvs", AdminLive.CSVLive.Index, :index
    live "/admin/csvs/new", AdminLive.CSVLive.Index, :new
    live "/admin/csvs/:id/edit", AdminLive.CSVLive.Index, :edit

    live "/admin/csvs/:id", AdminLive.CSVLive.Show, :show
    live "/admin/csvs/:id/show/edit", AdminLive.CSVLive.Show, :edit
  end

  scope "/", AIFAlbumsWeb do
    pipe_through [:browser]

    live "/", PageLive, :index

    live "/collections/:id", CollectionLive.Show, :show

    live "/albums", AlbumLive.Index, :index
    live "/albums/:id", AlbumLive.Show, :show
    live "/albums/:album_id/browse/:spread_id", AlbumLive.ShowSpread, :show

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
  end
end
