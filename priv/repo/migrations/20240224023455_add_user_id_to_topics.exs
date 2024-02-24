defmodule Discuss.Repo.Migrations.AddUserIdToTopics do
  use Ecto.Migration

  def change do
    alter table(:topics) do
      add :users_id, references(:users, on_delete: :delete_all)
    end
  end
end
