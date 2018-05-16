defmodule SetupPhoenixWeb.Router do
  use SetupPhoenixWeb, :router
  use SetupPhoenix.RollbaxErrorHandler

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SetupPhoenixWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    forward "/beaker", Beaker.Web
  end

  if Mix.env == :dev do
    scope "/dev" do
      pipe_through [:browser]

      forward "/mailbox", Plug.Swoosh.MailboxPreview, [base_path: "/dev/mailbox"]
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", SetupPhoenixWeb do
  #   pipe_through :api
  # end
end
