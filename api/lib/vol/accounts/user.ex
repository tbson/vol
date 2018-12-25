defmodule Vol.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Vol.Accounts.Credential

  schema "users" do
    field(:firstname, :string)
    field(:lastname, :string)
    field(:middlename, :string)

    has_one(:credential, Credential)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:firstname, :middlename, :lastname])
    |> validate_required([:firstname, :lastname])
  end

  def registration_changeset(user, attrs) do
    user
    |> changeset(attrs)
    |> cast_assoc(:credential, with: &Credential.changeset/2, required: true)
  end
end
