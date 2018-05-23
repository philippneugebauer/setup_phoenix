defmodule SetupPhoenix.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :firstname, :string
      add :lastname, :string
      add :encrypted_password, :string
      add :role, :string

      timestamps()
    end

  end
end
