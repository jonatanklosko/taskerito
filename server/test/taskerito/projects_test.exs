defmodule Taskerito.ProjectsTest do
  use Taskerito.DataCase

  alias Taskerito.Projects

  import Taskerito.Factory

  describe "projects" do
    alias Taskerito.Projects.Project

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    test "list_projects/0 returns all projects" do
      projects = insert_list(5, :project)
      actual_project_ids = Projects.list_projects() |> Enum.map(&(&1.id))
      expected_project_ids = projects |> Enum.map(&(&1.id))
      assert actual_project_ids == expected_project_ids
    end

    test "get_project!/1 returns the project with given id" do
      project = insert(:project)
      assert Projects.get_project!(project.id).id == project.id
    end

    test "create_project/1 with valid data creates a project" do
      author = insert(:user)
      assert {:ok, %Project{} = project} = Projects.create_project(author, @valid_attrs)
      assert project.description == "some description"
      assert project.name == "some name"
    end

    test "create_project/1 with invalid data returns error changeset" do
      author = insert(:user)
      assert {:error, %Ecto.Changeset{}} = Projects.create_project(author, @invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = insert(:project)
      assert {:ok, %Project{} = project} = Projects.update_project(project, @update_attrs)
      assert project.description == "some updated description"
      assert project.name == "some updated name"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = insert(:project)
      assert {:error, %Ecto.Changeset{}} = Projects.update_project(project, @invalid_attrs)
      assert project.id == Projects.get_project!(project.id).id
    end

    test "delete_project/1 deletes the project" do
      project = insert(:project)
      assert {:ok, %Project{}} = Projects.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Projects.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = build(:project)
      assert %Ecto.Changeset{} = Projects.change_project(project)
    end
  end

  describe "tasks" do
    alias Taskerito.Projects.Task

    @valid_attrs %{description: "some description", name: "some name", priority: 42}
    @update_attrs %{description: "some updated description", name: "some updated name", priority: 43}
    @invalid_attrs %{description: nil, name: nil, priority: nil}

    test "list_tasks/0 returns all tasks" do
      tasks = insert_list(5, :task)
      actual_task_ids = Projects.list_tasks() |> Enum.map(&(&1.id))
      expected_task_ids = tasks |> Enum.map(&(&1.id))
      assert actual_task_ids == expected_task_ids
    end

    test "get_task!/1 returns the task with given id" do
      task = insert(:task)
      assert Projects.get_task!(task.id).id == task.id
    end

    test "create_task/1 with valid data creates a task" do
      author = insert(:user)
      project = insert(:project)
      assert {:ok, %Task{} = task} = Projects.create_task(author, project, @valid_attrs)
      assert task.description == "some description"
      assert task.name == "some name"
      assert task.priority == 42
      assert task.author_id == author.id
      assert task.project_id == project.id
    end

    test "create_task/1 with invalid data returns error changeset" do
      author = insert(:user)
      project = insert(:project)
      assert {:error, %Ecto.Changeset{}} = Projects.create_task(author, project, @invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = insert(:task)
      assert {:ok, %Task{} = task} = Projects.update_task(task, @update_attrs)
      assert task.description == "some updated description"
      assert task.name == "some updated name"
      assert task.priority == 43
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = insert(:task)
      assert {:error, %Ecto.Changeset{}} = Projects.update_task(task, @invalid_attrs)
      assert task.id == Projects.get_task!(task.id).id
    end

    test "delete_task/1 deletes the task" do
      task = insert(:task)
      assert {:ok, %Task{}} = Projects.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Projects.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = build(:task)
      assert %Ecto.Changeset{} = Projects.change_task(task)
    end
  end

  describe "comments" do
    alias Taskerito.Projects.Comment

    @valid_attrs %{content: "some content"}
    @update_attrs %{content: "some updated content"}
    @invalid_attrs %{content: nil}

    test "list_comments/0 returns all comments" do
      comments = insert_list(5, :comment)
      actual_comment_ids = Projects.list_comments() |> Enum.map(&(&1.id))
      expected_comment_ids = comments |> Enum.map(&(&1.id))
      assert actual_comment_ids == expected_comment_ids
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = insert(:comment)
      assert Projects.get_comment!(comment.id).id == comment.id
    end

    test "create_comment/1 with valid data creates a comment" do
      author = insert(:user)
      task = insert(:task)
      assert {:ok, %Comment{} = comment} = Projects.create_comment(author, task, @valid_attrs)
      assert comment.content == "some content"
      assert comment.author_id == author.id
      assert comment.task_id == task.id
    end

    test "create_comment/1 with invalid data returns error changeset" do
      author = insert(:user)
      task = insert(:task)
      assert {:error, %Ecto.Changeset{}} = Projects.create_comment(author, task, @invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = insert(:comment)
      assert {:ok, %Comment{} = comment} = Projects.update_comment(comment, @update_attrs)
      assert comment.content == "some updated content"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = insert(:comment)
      assert {:error, %Ecto.Changeset{}} = Projects.update_comment(comment, @invalid_attrs)
      assert comment.id == Projects.get_comment!(comment.id).id
    end

    test "delete_comment/1 deletes the comment" do
      comment = insert(:comment)
      assert {:ok, %Comment{}} = Projects.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Projects.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = build(:comment)
      assert %Ecto.Changeset{} = Projects.change_comment(comment)
    end
  end
end
