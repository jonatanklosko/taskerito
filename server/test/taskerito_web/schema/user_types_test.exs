defmodule TaskeritoWeb.Schema.UserTypesTest do
  use TaskeritoWeb.ConnCase

  import Taskerito.Factory

  describe "query: current user" do
    @current_user_query """
    query CurrentUser {
      currentUser {
        id
        username
      }
    }
    """

    test "returns null when not authenticated", %{conn: conn} do
      conn = post(conn, "/api", %{"query" => @current_user_query})

      assert json_response(conn, 200) == %{"data" => %{"currentUser" => nil}}
    end

    @tag :signed_in
    test "returns user based on authentication token", %{conn: conn, current_user: current_user} do
      conn = post(conn, "/api", %{"query" => @current_user_query})

      assert json_response(conn, 200) == %{
        "data" => %{
          "currentUser" => %{
            "id" => Integer.to_string(current_user.id),
            "username" => current_user.username
          }
        }
      }
    end
  end

  describe "query: user projects" do
    @current_user_query """
    query CurrentUser {
      currentUser {
        projects {
          id
        }
      }
    }
    """

    @tag :signed_in
    test "returns a list of projects created by the given user", %{conn: conn, current_user: current_user} do
      project = insert(:project, author: current_user)
      insert(:project) # other project

      conn = post(conn, "/api", %{"query" => @current_user_query})

      assert json_response(conn, 200) == %{
        "data" => %{
          "currentUser" => %{
            "projects" => [%{"id" => Integer.to_string(project.id)}]
          }
        }
      }
    end
  end

  describe "query: user tasks" do
    @current_user_query """
    query CurrentUser {
      currentUser {
        tasks {
          id
        }
      }
    }
    """

    @tag :signed_in
    test "returns a list of tasks created by the given user", %{conn: conn, current_user: current_user} do
      task = insert(:task, author: current_user)
      insert(:task) # other task

      conn = post(conn, "/api", %{"query" => @current_user_query})

      assert json_response(conn, 200) == %{
        "data" => %{
          "currentUser" => %{
            "tasks" => [%{"id" => Integer.to_string(task.id)}]
          }
        }
      }
    end
  end

  describe "mutation: sign up" do
    @sign_up_mutation """
    mutation SignUp($input: SignUpInput!) {
      signUp(input: $input) {
        successful
        messages {
          message
        }
        result {
          token
          user {
            username
          }
        }
      }
    }
    """

    test "returns user and token when successful", %{conn: conn} do
      input = %{
        "username" => "sholmes",
        "name" => "Sherlock Holmes",
        "password" => "password",
        "email" => "sholmes@example.com"
      }
      conn = post(conn, "/api", %{
        "query" => @sign_up_mutation,
        "variables" => %{"input" => input}
      })

      data = json_response(conn, 200)["data"]
      assert data["signUp"]["successful"] == true
      assert data["signUp"]["messages"] == []
      assert String.length(data["signUp"]["result"]["token"]) > 0
      assert data["signUp"]["result"]["user"]["username"] == "sholmes"
    end

    test "returns error messages when not successful", %{conn: conn} do
      input = %{
        "username" => "sholmes",
        "name" => "Sherlock Holmes",
        "password" => "password"
      }
      conn = post(conn, "/api", %{
        "query" => @sign_up_mutation,
        "variables" => %{"input" => input}
      })

      assert json_response(conn, 200) == %{
        "data" => %{
          "signUp" => %{
            "successful" => false,
            "messages" => [%{"message" => "can't be blank"}],
            "result" => nil
          }
        }
      }
    end
  end

  describe "mutation: sign in" do
    @sign_in_mutation """
    mutation SignIn($username: String!, $password: String!) {
      signIn(username: $username, password: $password) {
        successful
        messages {
          message
        }
        result {
          token
          user {
            username
          }
        }
      }
    }
    """

    test "returns user and token when successful", %{conn: conn} do
      user = build(:user) |> set_password("password") |> insert

      conn = post(conn, "/api", %{
        "query" => @sign_in_mutation,
        "variables" => %{
          "username" => user.username,
          "password" => "password"
        }
      })

      data = json_response(conn, 200)["data"]
      assert data["signIn"]["successful"] == true
      assert data["signIn"]["messages"] == []
      assert String.length(data["signIn"]["result"]["token"]) > 0
      assert data["signIn"]["result"]["user"]["username"] == user.username
    end

    test "returns error messages when not successful", %{conn: conn} do
      conn = post(conn, "/api", %{
        "query" => @sign_in_mutation,
        "variables" => %{
          "username" => "nonexistent",
          "password" => "whatever"
        }
      })

      assert json_response(conn, 200) == %{
        "data" => %{
          "signIn" => %{
            "successful" => false,
            "messages" => [%{"message" => "not_found"}],
            "result" => nil
          }
        }
      }
    end
  end
end
