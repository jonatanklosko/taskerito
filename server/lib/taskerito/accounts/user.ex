defmodule Taskerito.Accounts.User do
  use Taskerito.Schema
  import Ecto.Changeset

  alias Taskerito.Projects.{Project, Task, Comment}

  schema "users" do
    field :email, :string
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :projects, Project, foreign_key: :author_id
    has_many :tasks, Task, foreign_key: :author_id
    has_many :comments, Comment, foreign_key: :author_id
    many_to_many :assigned_tasks, Task, join_through: "task_assignments", on_replace: :delete

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :name, :email])
    |> validate_required([:username, :name, :email])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end

  def sign_up_changeset(user, attrs) do
    user
    |> changeset(attrs)
    |> cast(attrs, [:password])
    |> validate_required(:password)
    |> validate_length(:password, min: 8)
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
