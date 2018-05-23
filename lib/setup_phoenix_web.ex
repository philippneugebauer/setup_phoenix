defmodule SetupPhoenixWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use SetupPhoenixWeb, :controller
      use SetupPhoenixWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def model do
    quote do
      use Ecto.Schema

      import Ecto.Changeset
      import Ecto.Queryable

      import SetupPhoenixWeb.Gettext

      @timestamps_opts [type: Timex.Ecto.DateTime, autogenerate: {Timex.Ecto.DateTime, :autogenerate, [:usec]}]
    end
  end

  def controller do
    quote do
      use Phoenix.Controller, namespace: SetupPhoenixWeb
      import Plug.Conn
      import SetupPhoenixWeb.Router.Helpers
      import SetupPhoenixWeb.Gettext

      alias Ecto.Changeset
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/setup_phoenix_web/templates",
                        namespace: SetupPhoenixWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import SetupPhoenixWeb.Router.Helpers
      import SetupPhoenixWeb.ErrorHelpers
      import SetupPhoenixWeb.FontAwesomeHelpers
      import SetupPhoenixWeb.TimeHelpers
      import SetupPhoenixWeb.Gettext
    end
  end

  def email do
    quote do
      use Phoenix.View, root: "lib/setup_phoenix_web/templates",
                        namespace: SetupPhoenixWeb

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import SetupPhoenixWeb.Router.Helpers
      import SetupPhoenixWeb.ErrorHelpers
      import SetupPhoenixWeb.FontAwesomeHelpers
      import SetupPhoenixWeb.TimeHelpers
      import SetupPhoenixWeb.Gettext
      import Swoosh.Email
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import SetupPhoenixWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
