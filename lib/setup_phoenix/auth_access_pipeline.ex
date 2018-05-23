defmodule SetupPhoenix.AuthAccessPipeline do
  @moduledoc """
    Provides the Guardian AuthAccessPipeline to verify the session data and to load and set the user
  """
  use Guardian.Plug.Pipeline, otp_app: :setup_phoenix

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
  plug SetupPhoenix.Plug.CurrentUserPlug
end
