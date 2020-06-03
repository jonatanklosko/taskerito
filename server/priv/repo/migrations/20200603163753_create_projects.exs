defmodule Taskerito.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string, null: false
      add :description, :string, null: false
      add :author_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:projects, [:author_id])
  end
end
