defmodule TaskeritoWeb.Schema.TaskTypesTest do
  use TaskeritoWeb.ConnCase

  import Taskerito.Factory

  describe "query: task list" do
    @tasks_query """
    query Tasks {
      tasks {
        id
        name
      }
    }
    """

    test "returns a list of all tasks", %{conn: conn} do
      insert_list(5, :task)

      conn = post(conn, "/api", %{"query" => @tasks_query})

      data = json_response(conn, 200)["data"]
      assert length(data["tasks"]) == 5
    end
  end

  describe "query: find task" do
    @task_query """
    query Task($id: ID!) {
      task(id: $id) {
        id
        name
        project {
          id
        }
      }
    }
    """

    test "returns a list of all projects", %{conn: conn} do
      task = insert(:task)

      conn = post(conn, "/api", %{
        "query" => @task_query,
        "variables" => %{"id" => to_gql_id(task.id)}
      })

      assert json_response(conn, 200) == %{
        "data" => %{
          "task" => %{
            "id" => to_gql_id(task.id),
            "name" => task.name,
            "project" => %{"id" => to_gql_id(task.project.id)}
          }
        }
      }
    end
  end

  describe "mutation: create task" do
    @create_task_mutation """
    mutation CreateTask($projectId: ID!, $input: TaskInput!) {
      createTask(projectId: $projectId, input: $input) {
        successful
        messages {
          message
        }
        result {
          name
          author {
            username
          }
          project {
            id
          }
        }
      }
    }
    """

    @valid_input %{
      "name" => "Eat burrito",
      "description" => "Need to buy burrito then eat it.",
      "priority" => 1
    }

    @invalid_input %{
      "name" => "",
      "description" => "Need to buy burrito then eat it.",
      "priority" => 1
    }

    @tag :signed_in
    test "returns task when successful", %{conn: conn, current_user: current_user} do
      project = insert(:project, author: current_user)

      conn = post(conn, "/api", %{
        "query" => @create_task_mutation,
        "variables" => %{
          "projectId" => to_gql_id(project.id),
          "input" => @valid_input
        }
      })

      assert json_response(conn, 200) == %{
        "data" => %{
          "createTask" => %{
            "successful" => true,
            "messages" => [],
            "result" => %{
              "name" => "Eat burrito",
              "author" => %{"username" => current_user.username},
              "project" => %{"id" => to_gql_id(project.id)}
            }
          }
        }
      }
    end

    @tag :signed_in
    test "returns errors messages when data is invalid", %{conn: conn, current_user: current_user} do
      project = insert(:project, author: current_user)

      conn = post(conn, "/api", %{
        "query" => @create_task_mutation,
        "variables" => %{
          "projectId" => to_gql_id(project.id),
          "input" => @invalid_input
        }
      })

      assert json_response(conn, 200) == %{
        "data" => %{
          "createTask" => %{
            "successful" => false,
            "messages" => [%{"message" => "can't be blank"}],
            "result" => nil
          }
        }
      }
    end

    @tag :signed_in
    test "returns errors messages when user doesn't own the project", %{conn: conn} do
      project = insert(:project)

      conn = post(conn, "/api", %{
        "query" => @create_task_mutation,
        "variables" => %{
          "projectId" => to_gql_id(project.id),
          "input" => @valid_input
        }
      })

      assert json_response(conn, 200) == %{
        "data" => %{
          "createTask" => %{
            "successful" => false,
            "messages" => [%{"message" => "not_authorized"}],
            "result" => nil
          }
        }
      }
    end
  end

  describe "mutation: finish task" do
    @finish_task_mutation """
    mutation FinishTask($id: ID!) {
      finishTask(id: $id) {
        successful
        messages {
          message
        }
        result {
          finishedAt
        }
      }
    }
    """

    @tag :signed_in
    test "returns task when successful", %{conn: conn, current_user: current_user} do
      task = insert(:task, author: current_user)

      conn = post(conn, "/api", %{
        "query" => @finish_task_mutation,
        "variables" => %{
          "id" => to_gql_id(task.id)
        }
      })

      data = json_response(conn, 200)["data"]
      assert data["finishTask"]["result"]["finishedAt"] != nil
    end
  end

  describe "mutation: assign task" do
    @assign_task_mutation """
    mutation AssignTask($id: ID!, $userId: ID!) {
      assignTask(id: $id, userId: $userId) {
        successful
        messages {
          message
        }
        result {
          assignees {
            id
          }
        }
      }
    }
    """

    @tag :signed_in
    test "returns task when successful", %{conn: conn, current_user: current_user} do
      task = insert(:task, author: current_user)
      user = insert(:user)

      conn = post(conn, "/api", %{
        "query" => @assign_task_mutation,
        "variables" => %{
          "id" => to_gql_id(task.id),
          "userId" => to_gql_id(user.id)
        }
      })

      data = json_response(conn, 200)["data"]
      assert data["assignTask"]["result"]["assignees"] == [%{"id" => to_gql_id(user.id)}]
    end
  end

  describe "mutation: unassign task" do
    @unassign_task_mutation """
    mutation UnassignTask($id: ID!, $userId: ID!) {
      unassignTask(id: $id, userId: $userId) {
        successful
        messages {
          message
        }
        result {
          assignees {
            id
          }
        }
      }
    }
    """

    @tag :signed_in
    test "returns task when successful", %{conn: conn, current_user: current_user} do
      user = insert(:user)
      task = insert(:task, author: current_user, assignees: [user])

      conn = post(conn, "/api", %{
        "query" => @unassign_task_mutation,
        "variables" => %{
          "id" => to_gql_id(task.id),
          "userId" => to_gql_id(user.id)
        }
      })

      data = json_response(conn, 200)["data"]
      assert data["unassignTask"]["result"]["assignees"] == []
    end
  end
end
