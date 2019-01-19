defmodule Vol.Repo.Migrations.CreateVariables do
  use Ecto.Migration

  def change do
    create table(:variables) do
      add(:uid, :string, null: false)
      add(:value, :string)

      timestamps()
    end

    create(unique_index(:variables, [:uid]))
  end
end
