defmodule TaskeritoWeb.Auth do
  @token_seed "user-auth"
  @token_max_age 86400

  def verify_token(token) do
    Phoenix.Token.verify(TaskeritoWeb.Endpoint, @token_seed, token, max_age: @token_max_age)
  end

  def generate_token(user_id) do
    Phoenix.Token.sign(TaskeritoWeb.Endpoint, @token_seed, user_id)
  end
end
