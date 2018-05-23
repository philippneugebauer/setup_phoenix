defmodule SetupPhoenix.Accounts.User do
  use SetupPhoenixWeb, :model

  alias SetupPhoenix.Accounts.User
  alias SetupPhoenix.Repo

  alias Comeonin.Bcrypt

  defdelegate authorize(action, user, params), to: SetupPhoenix.Abilities

  schema "users" do
    field :encrypted_password, :string
    field :firstname, :string
    field :lastname, :string
    field :role, :string
    field :password, :string, virtual: true

    timestamps()
  end

  def check_credentials(params = %{"firstname" => firstname, "password" => password}) do
    user = Repo.get_by(User, firstname: firstname)
    compare_password(password, user, params)
  end

  defp compare_password(password, user = %User{}, params) do
    if Bcrypt.checkpw(password, user.encrypted_password) do
      {:ok, user}
    else
      login_error(params)
    end
  end

  defp login_error(params) do
    changeset = %User{}
      |> cast(params, [:email])
      |> add_error(:base, gettext("Email and/or Password are wrong!"))
    {:error, changeset}
  end

  @doc false
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:firstname, :lastname, :password, :role])
    |> validate_required([:firstname, :lastname, :password, :role])
    |> hash_password()
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :encrypted_password, Bcrypt.hashpwsalt(pass))
      _ -> changeset
    end
  end
end
