defmodule Taskerito.Projects do
  @moduledoc """
  The Projects context.
  """

  import Ecto.Query, warn: false
  alias Taskerito.Repo
  alias Taskerito.Projects.{Project, Task, Comment}
  alias Taskerito.Accounts.User

  @doc """
  Returns the list of projects.
  """
  def list_projects do
    Repo.all(Project)
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
  def create_project(%User{} = user, attrs \\ %{}) do
    %Project{}
    |> Project.changeset(attrs)
    |> Ecto.Changeset.put_change(:author_id, user.id)
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
  Returns the list of tasks.
  """
  def list_tasks do
    Repo.all(Task)
  end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.
  """
  def get_task!(id), do: Repo.get!(Task, id)

  @doc """
  Gets a single task.

  Returns {:ok, %Task{}} or {:error, ...}.
  """
  def get_task(id), do: Repo.get(Task, id)

  @doc """
  Creates a task.
  """
  def create_task(%User{} = user, %Project{} = project, attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Ecto.Changeset.put_change(:author_id, user.id)
    |> Ecto.Changeset.put_change(:project_id, project.id)
    |> Repo.insert()
  end

  @doc """
  Updates a task.
  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a task.
  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.
  """
  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end

  @doc """
  Marks a task as finished.
  """
  def finish_task(%Task{} = task) do
    task
    |> Task.changeset(%{finished_at: DateTime.utc_now})
    |> Repo.update()
  end

  @doc """
  Returns the list of comments.
  """
  def list_comments do
    Repo.all(Comment)
  end

  @doc """
  Gets a single comment.

  Raises `Ecto.NoResultsError` if the Comment does not exist.
  """
  def get_comment!(id), do: Repo.get!(Comment, id)

  @doc """
  Creates a comment.
  """
  def create_comment(%User{} = user, %Task{} = task, attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Ecto.Changeset.put_change(:author_id, user.id)
    |> Ecto.Changeset.put_change(:task_id, task.id)
    |> Repo.insert()
  end

  @doc """
  Updates a comment.
  """
  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a comment.
  """
  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking comment changes.
  """
  def change_comment(%Comment{} = comment, attrs \\ %{}) do
    Comment.changeset(comment, attrs)
  end
end
