defmodule SetupPhoenix.Mailer do
  @moduledoc """
    General mailer module for allowing to send emails in async tasks
  """
  use Swoosh.Mailer, otp_app: :setup_phoenix
  use SetupPhoenixWeb, :email
  use Phoenix.Swoosh, view: SetupPhoenixWeb.UserEmailView, layout: {SetupPhoenixWeb.LayoutView, :email}

  alias SetupPhoenix.Mailer
  alias Swoosh.Email

  require Logger

  def send_email_async(email, subject, html, params \\ %{}) do
    Task.async(fn ->
      {response, _id} =
        %Email{}
        |> from({"SetupPhoenix", "setup@phoenix.com"})
        |> to(email)
        |> subject(subject)
        |> render_body(html, params)
        |> Mailer.deliver()

      Logger.info("Email response: #{response}")
    end)
  end
end
