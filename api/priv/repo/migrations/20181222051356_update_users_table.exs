defmodule Vol.Repo.Migrations.UpdateUsersTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify(:firstname, :string, null: false)
      modify(:lastname, :string, null: false)
    end
  end
end
