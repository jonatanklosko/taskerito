defmodule TaskeritoWeb.Schema.ProjectTypesTest do
  use TaskeritoWeb.ConnCase

  import Taskerito.Factory

  describe "query: project list" do
    @projects_query """
    query Projects {
      projects(orderBy: INSERTED_AT_ASC) {
        id
        name
      }
    }
    """

    test "returns a list of all projects", %{conn: conn} do
      insert_list(5, :project)

      conn = post(conn, "/api", %{"query" => @projects_query})

      data = json_response(conn, 200)["data"]
      assert length(data["projects"]) == 5
    end
  end

  describe "query: find project" do
    @project_query """
    query Project($id: ID!) {
      project(id: $id) {
        id
        name
        tasks(orderBy: INSERTED_AT_ASC) {
          id
        }
      }
    }
    """

    test "returns a list of all projects", %{conn: conn} do
      project = insert(:project)
      task = insert(:task, project: project)

      conn =
        post(conn, "/api", %{
          "query" => @project_query,
          "variables" => %{"id" => to_gql_id(project.id)}
        })

      assert json_response(conn, 200) == %{
               "data" => %{
                 "project" => %{
                   "id" => to_gql_id(project.id),
                   "name" => project.name,
                   "tasks" => [%{"id" => to_gql_id(task.id)}]
                 }
               }
             }
    end
  end

  describe "mutation: create project" do
    @create_project_mutation """
    mutation CreateProject($input: ProjectInput!) {
      createProject(input: $input) {
        successful
        messages {
          message
        }
        result {
          name
          author {
            username
          }
        }
      }
    }
    """

    @tag :signed_in
    test "returns project when successful", %{conn: conn, current_user: current_user} do
      input = %{
        "name" => "Project Y",
        "description" => "Top priority stuff."
      }

      conn =
        post(conn, "/api", %{
          "query" => @create_project_mutation,
          "variables" => %{"input" => input}
        })

      assert json_response(conn, 200) == %{
               "data" => %{
                 "createProject" => %{
                   "successful" => true,
                   "messages" => [],
                   "result" => %{
                     "name" => "Project Y",
                     "author" => %{"username" => current_user.username}
                   }
                 }
               }
             }
    end

    @tag :signed_in
    test "returns errors messages when data is invalid", %{conn: conn} do
      input = %{
        "name" => "",
        "description" => "Top priority stuff."
      }

      conn =
        post(conn, "/api", %{
          "query" => @create_project_mutation,
          "variables" => %{"input" => input}
        })

      assert json_response(conn, 200) == %{
               "data" => %{
                 "createProject" => %{
                   "successful" => false,
                   "messages" => [%{"message" => "can't be blank"}],
                   "result" => nil
                 }
               }
             }
    end
  end
end
