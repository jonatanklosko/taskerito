defmodule TaskeritoWeb.Context do
  @behaviour Plug

  import Plug.Conn
  alias Taskerito.Accounts

  def init(opts), do: opts

  @doc """
  Adds GraphQL context to the connection.
  The context includes current user extracted from an authorization token if present.
  """
  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
    {:ok, current_user} <- authorize(token) do
      %{current_user: current_user}
    else
      _ -> %{}
    end
  end

  defp authorize(token) do
    with {:ok, user_id} <- Phoenix.Token.verify(TaskeritoWeb.Endpoint, "user-auth", token, max_age: 86400) do
      case Accounts.get_user(user_id) do
        nil -> {:error, "invalid authorization token"}
        user -> {:ok, user}
      end
    end
  end
end
