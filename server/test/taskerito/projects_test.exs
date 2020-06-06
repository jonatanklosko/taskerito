defmodule Taskerito.ProjectsTest do
  use Taskerito.DataCase

  import Taskerito.Factory

  alias Taskerito.Projects.{Project, Projects}

  @valid_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  test "list_projects/0 returns all projects" do
    projects = insert_list(5, :project)
    actual_project_ids = Projects.list_projects() |> Enum.map(& &1.id)
    expected_project_ids = projects |> Enum.map(& &1.id)
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
