defmodule Taskerito.Projects.Tasks do
  @moduledoc """
  The module for Task management.
  """

  import Ecto.Query, warn: false
  alias Taskerito.Repo
  alias Taskerito.Projects.{Project, Task}
  alias Taskerito.Accounts.User

  @doc """
  Returns the list of tasks.
  """
  def list_tasks(args \\ %{}) do
    order_by = args[:order_by] || [asc: :inserted_at]

    Task
    |> order_by(^order_by)
    |> Repo.all()
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
  def create_task(%User{} = author, %Project{} = project, attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Ecto.Changeset.put_change(:author_id, author.id)
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
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_change(:finished_at, DateTime.truncate(DateTime.utc_now(), :second))
    |> Repo.update()
  end

  @doc """
  Assigns a task to the given user.
  """
  def assign_task(%Task{} = task, %User{} = user) do
    task = Repo.preload(task, :assignees)

    task
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:assignees, [user | task.assignees])
    |> Repo.update()
  end

  @doc """
  Unassigns a task from the given user.
  """
  def unassign_task(%Task{} = task, %User{} = user) do
    task = Repo.preload(task, :assignees)
    assignees = Enum.filter(task.assignees, fn assignee -> assignee.id != user.id end)

    task
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:assignees, assignees)
    |> Repo.update()
  end

  @doc """
  Returns whether a user can manage a task.
  """
  def can_manage_task(%Task{} = task, %User{} = user) do
    task.author_id == user.id
  end
end
