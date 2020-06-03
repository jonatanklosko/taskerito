defmodule Taskerito.Projects.Project do
  use Ecto.Schema
  import Ecto.Changeset

  alias Taskerito.Accounts

  schema "projects" do
    field :description, :string
    field :name, :string
    belongs_to :author, Accounts.User

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
