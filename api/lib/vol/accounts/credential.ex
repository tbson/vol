defmodule Vol.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Argon2, only: [hashpwsalt: 1]

  schema "credentials" do
    field(:email, :string)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)
    belongs_to(:user, Vol.Accounts.User)

    timestamps()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, hashpwsalt(pass))

      _ ->
        changeset
    end
  end

  @doc false
  def changeset(credential, attrs) do
    credential
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_length(:password, min: 6, max: 100)
    |> unique_constraint(:email)
    |> put_pass_hash()
  end
end
