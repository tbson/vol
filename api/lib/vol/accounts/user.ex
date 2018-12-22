defmodule Vol.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:firstname, :string)
    field(:lastname, :string)
    field(:middlename, :string)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:firstname, :middlename, :lastname])
    |> validate_required([:firstname, :lastname])
  end
end
