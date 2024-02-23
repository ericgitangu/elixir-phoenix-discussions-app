defmodule Discuss.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  @derive {Jason.Encoder, only: [:email, :avatar_url, :name]}
  def change do
    create table(:users) do
      add :email, :string
      add :avatar_url, :string
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
