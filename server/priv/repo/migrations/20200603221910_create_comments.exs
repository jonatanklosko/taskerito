defmodule Taskerito.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :content, :text, null: false
      add :author_id, references(:users, on_delete: :nothing), null: false
      add :task_id, references(:tasks, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:comments, [:author_id])
    create index(:comments, [:task_id])
  end
end
