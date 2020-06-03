defmodule TaskeritoWeb.Schema.AccountTypes do
  use Absinthe.Schema.Notation

  alias TaskeritoWeb.Resolvers
  import AbsintheErrorPayload.Payload

  import_types AbsintheErrorPayload.ValidationMessageTypes

  @desc "A user of the application."
  object :user do
    field :id, non_null(:id)
    field :username, non_null(:string)
    field :name, non_null(:string)
    field :email, non_null(:string)
  end

  object :token_payload do
    field :user, non_null(:user)
    field :token, non_null(:string)
  end

  input_object :sign_up_input do
    field :username, :string
    field :password, :string
    field :name, :string
    field :email, :string
  end

  payload_object(:auth_payload, :token_payload)

  object :user_queries do
    field :current_user, :user do
      resolve &Resolvers.Accounts.current_user/3
    end
  end

  object :user_mutations do
    field :sign_up, non_null(:auth_payload) do
      arg :input, non_null(:sign_up_input)
      resolve &Resolvers.Accounts.sign_up/3
      middleware &build_payload/2
    end

    field :sign_in, non_null(:auth_payload) do
      arg :username, non_null(:string)
      arg :password, non_null(:string)
      resolve &Resolvers.Accounts.sign_in/3
      middleware &build_payload/2
    end
  end
end
