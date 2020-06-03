defmodule Taskerito.Projects.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias Taskerito.Accounts.User
  alias Taskerito.Projects.Task

  schema "comments" do
    field :content, :string

    belongs_to :author, User
    belongs_to :task, Task

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
