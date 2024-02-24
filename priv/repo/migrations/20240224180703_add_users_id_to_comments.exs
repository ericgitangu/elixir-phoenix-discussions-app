defmodule Discuss.Repo.Migrations.AddUsersIdToComments do
  use Ecto.Migration

  def change do
    alter table(:comments) do
      add :users_id, references(:users, on_delete: :delete_all)
    end
  end
end
