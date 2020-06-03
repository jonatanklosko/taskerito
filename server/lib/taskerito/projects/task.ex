defmodule Taskerito.Projects.Task do
  use Ecto.Schema
  import Ecto.Changeset

  alias Taskerito.Accounts.User
  alias Taskerito.Projects.Project

  schema "tasks" do
    field :description, :string
    field :name, :string
    field :priority, :integer

    belongs_to :author, User
    belongs_to :project, Project

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name, :description, :priority])
    |> validate_required([:name, :description, :priority])
  end
end
