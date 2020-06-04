defmodule TaskeritoWeb.Schema.UserTypesTest do
  use TaskeritoWeb.ConnCase

  import Taskerito.Factory

  setup context do
    if context[:signed_in] do
      user = insert(:user)
      token = Phoenix.Token.sign(TaskeritoWeb.Endpoint, "user-auth", user.id)
      conn = context[:conn]
        |> Plug.Conn.put_req_header("authorization", "Bearer #{token}")
      {:ok, %{current_user: user, conn: conn}}
    else
      :ok
    end
  end

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

      assert json_response(conn, 200) ==
        %{
          "data" => %{
            "currentUser" => %{
              "id" => Integer.to_string(current_user.id),
              "username" => current_user.username
            }
          }
        }
    end
  end
end
