defmodule SetupPhoenix.Abilities do
  @moduledoc """
    Defines what each user is allowed to in each context
  """
  @behaviour Bodyguard.Policy

  alias SetupPhoenix.Accounts.User

  # SESSIONS
  def authorize(:create_session, nil, nil), do: true
  def authorize(:destroy_session, %User{}, nil), do: true

  # USER
  def authorize(:read_user, %User{}, _), do: true
  def authorize(:write_user, %User{role: "admin"}, nil), do: true

  def authorize(_, _, _), do: false
end
