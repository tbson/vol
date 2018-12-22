defmodule Vol.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:firstname, :string)
      add(:middlename, :string)
      add(:lastname, :string)

      timestamps()
    end
  end
end