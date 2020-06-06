defmodule Taskerito.TasksTest do
  use Taskerito.DataCase

  import Taskerito.Factory

  alias Taskerito.Projects.{Task, Tasks}

  @valid_attrs %{description: "some description", name: "some name", priority: 42}
  @update_attrs %{description: "some updated description", name: "some updated name", priority: 43}
  @invalid_attrs %{description: nil, name: nil, priority: nil}

  test "list_tasks/0 returns all tasks" do
    tasks = insert_list(5, :task)
    actual_task_ids = Tasks.list_tasks() |> Enum.map(&(&1.id))
    expected_task_ids = tasks |> Enum.map(&(&1.id))
    assert actual_task_ids == expected_task_ids
  end

  test "get_task!/1 returns the task with given id" do
    task = insert(:task)
    assert Tasks.get_task!(task.id).id == task.id
  end

  test "create_task/1 with valid data creates a task" do
    author = insert(:user)
    project = insert(:project)
    assert {:ok, %Task{} = task} = Tasks.create_task(author, project, @valid_attrs)
    assert task.description == "some description"
    assert task.name == "some name"
    assert task.priority == 42
    assert task.author_id == author.id
    assert task.project_id == project.id
  end

  test "create_task/1 with invalid data returns error changeset" do
    author = insert(:user)
    project = insert(:project)
    assert {:error, %Ecto.Changeset{}} = Tasks.create_task(author, project, @invalid_attrs)
  end

  test "update_task/2 with valid data updates the task" do
    task = insert(:task)
    assert {:ok, %Task{} = task} = Tasks.update_task(task, @update_attrs)
    assert task.description == "some updated description"
    assert task.name == "some updated name"
    assert task.priority == 43
  end

  test "update_task/2 with invalid data returns error changeset" do
    task = insert(:task)
    assert {:error, %Ecto.Changeset{}} = Tasks.update_task(task, @invalid_attrs)
    assert task.id == Tasks.get_task!(task.id).id
  end

  test "delete_task/1 deletes the task" do
    task = insert(:task)
    assert {:ok, %Task{}} = Tasks.delete_task(task)
    assert_raise Ecto.NoResultsError, fn -> Tasks.get_task!(task.id) end
  end

  test "change_task/1 returns a task changeset" do
    task = build(:task)
    assert %Ecto.Changeset{} = Tasks.change_task(task)
  end

  test "assign_task/1 adds the task to user assignments" do
    user = insert(:user)
    task = insert(:task)
    assert {:ok, %Task{}} = Tasks.assign_task(task, user)
    task = Taskerito.Repo.preload(task, :assignees, force: true)
    assert Enum.member?(task.assignees, user)
  end

  test "unassign_task/1 remove the task from user assignments" do
    user = insert(:user)
    task = insert(:task, assignees: [user])
    assert {:ok, %Task{}} = Tasks.unassign_task(task, user)
    task = Taskerito.Repo.preload(task, :assignees, force: true)
    assert !Enum.member?(task.assignees, user)
  end
end
