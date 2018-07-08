defmodule SetupPhoenix.Avatar do
  @moduledoc """
    Avatar for user module
  """
  use Arc.Definition
  use Arc.Ecto.Definition

  @versions [:original]

  # Whitelist file extensions:
  def validate({file, _}) do
    ~w(.jpg) |> Enum.member?(Path.extname(file.file_name))
  end

  # Override the persisted filenames:
  def filename(version, _) do
    version
  end

  # Override the storage directory:
  def storage_dir(_version, {_file, scope}) do
    "uploads/users/avatar/#{scope.id}"
  end

  def default_url(:original) do
    "https://placehold.it/100x100"
  end
end
