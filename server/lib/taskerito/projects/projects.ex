defmodule Taskerito.Projects.Projects do
  @moduledoc """
  The module for Project management.
  """

  import Ecto.Query, warn: false
  alias Taskerito.Repo
  alias Taskerito.Projects.Project
  alias Taskerito.Accounts.User

  @doc """
  Returns the list of projects.
  """
  def list_projects(args \\ %{}) do
    order_by = args[:order_by] || [asc: :inserted_at]

    Project
    |> order_by(^order_by)
    |> Repo.all()
  end

  @doc """
  Gets a single project.

  Raises `Ecto.NoResultsError` if the Project does not exist.
  """
  def get_project!(id), do: Repo.get!(Project, id)

  @doc """
  Gets a single project.

  Returns {:ok, %Project{}} or {:error, ...}.
  """
  def get_project(id), do: Repo.get(Project, id)

  @doc """
  Creates a project.
  """
  def create_project(%User{} = author, attrs \\ %{}) do
    %Project{}
    |> Project.changeset(attrs)
    |> Ecto.Changeset.put_change(:author_id, author.id)
    |> Repo.insert()
  end

  @doc """
  Updates a project.
  """
  def update_project(%Project{} = project, attrs) do
    project
    |> Project.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a project.
  """
  def delete_project(%Project{} = project) do
    Repo.delete(project)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking project changes.
  """
  def change_project(%Project{} = project, attrs \\ %{}) do
    Project.changeset(project, attrs)
  end

  @doc """
  Returns whether a user can manage a project.
  """
  def can_manage_project(%Project{} = project, %User{} = user) do
    project.author_id == user.id
  end
end
