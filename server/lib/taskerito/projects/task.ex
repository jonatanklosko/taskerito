defmodule Taskerito.Projects.Task do
  use Taskerito.Schema
  import Ecto.Changeset

  alias Taskerito.Accounts.User
  alias Taskerito.Projects.{Project, Comment}

  schema "tasks" do
    field :description, :string
    field :name, :string
    field :priority, :integer
    field :finished_at, :utc_datetime

    belongs_to :author, User
    belongs_to :project, Project
    has_many :comments, Comment
    many_to_many :assignees, User, join_through: "task_assignments"

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name, :description, :priority, :finished_at])
    |> validate_required([:name, :description, :priority])
  end
end
