defmodule SetupPhoenix.Guardian do
  @moduledoc """
    The Guardian module to set and retrieve the user data from the session
  """
  use Guardian, otp_app: :setup_phoenix

  alias SetupPhoenix.Accounts.User
  alias SetupPhoenix.Repo

  def subject_for_token(%User{} = user, _claims) do
    {:ok, user.firstname}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(%{"sub" => firstname}) do
    user =
      User
      |> Repo.get_by(firstname: firstname)
    {:ok, user}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end

end
