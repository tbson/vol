defmodule Vol.Variables.Variable do
  use Ecto.Schema
  import Ecto.Changeset


  schema "variables" do
    field :uid, :string
    field :value, :string

    timestamps()
  end

  @doc false
  def changeset(variable, attrs) do
    variable
    |> cast(attrs, [:uid, :value])
    |> validate_required([:uid, :value])
    |> unique_constraint(:uid)
  end
end
