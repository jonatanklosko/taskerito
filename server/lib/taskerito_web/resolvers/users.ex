defmodule TaskeritoWeb.Resolvers.Users do
  alias Taskerito.Accounts.Users

  def current_user(_parent, _args, %{context: %{current_user: current_user}}) do
    {:ok, current_user}
  end

  def current_user(_parent, _args, _resolution), do: {:ok, nil}

  def sign_up(_parent, %{input: input}, _resolution) do
    Users.create_user(input)
    |> to_token_payload()
  end

  def sign_in(_parent, %{username: username, password: password}, _resolution) do
    Users.authenticate_by_username_password(username, password)
    |> to_token_payload()
  end

  defp to_token_payload({:ok, user}) do
    token = Phoenix.Token.sign(TaskeritoWeb.Endpoint, "user-auth", user.id)
    {:ok, %{token: token, user: user}}
  end

  defp to_token_payload({:error, error}), do: {:error, error}
end
