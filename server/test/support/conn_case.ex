defmodule TaskeritoWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use TaskeritoWeb.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      import TaskeritoWeb.ConnCase

      alias TaskeritoWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint TaskeritoWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Taskerito.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Taskerito.Repo, {:shared, self()})
    end

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end

  # Handle custom tags

  import Taskerito.Factory

  setup context do
    if context[:signed_in] do
      user = insert(:user)
      token = TaskeritoWeb.Auth.generate_token(user.id)

      conn =
        context[:conn]
        |> Plug.Conn.put_req_header("authorization", "Bearer #{token}")

      {:ok, %{current_user: user, conn: conn}}
    else
      :ok
    end
  end

  def to_gql_id(number) when is_integer(number) do
    Integer.to_string(number)
  end
end
