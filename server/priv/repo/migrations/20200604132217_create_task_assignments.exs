defmodule Taskerito.Repo.Migrations.CreateTaskAssignments do
  use Ecto.Migration

  def change do
    create table(:task_assignments, primary_key: false) do
      add :task_id, references(:tasks), null: false
      add :user_id, references(:users), null: false
    end

    create index(:task_assignments, [:user_id])
    create unique_index(:task_assignments, [:task_id, :user_id])
  end
end
