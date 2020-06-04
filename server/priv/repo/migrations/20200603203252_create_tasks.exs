defmodule Taskerito.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :name, :string, null: false
      add :description, :text, null: false
      add :priority, :integer, null: false
      add :author_id, references(:users, on_delete: :nothing), null: false
      add :project_id, references(:projects, on_delete: :delete_all), null: false
      add :finished_at, :utc_datetime

      timestamps()
    end

    create index(:tasks, [:author_id])
    create index(:tasks, [:project_id])
  end
end
