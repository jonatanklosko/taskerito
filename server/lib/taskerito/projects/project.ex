defmodule Taskerito.Projects.Project do
  use Ecto.Schema
  import Ecto.Changeset

  alias Taskerito.Accounts.User
  alias Taskerito.Projects.Task

  schema "projects" do
    field :description, :string
    field :name, :string

    belongs_to :author, User
    has_many :tasks, Task

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
