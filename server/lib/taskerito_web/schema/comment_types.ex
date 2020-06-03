defmodule TaskeritoWeb.Schema.CommentTypes do
  use Absinthe.Schema.Notation

  alias TaskeritoWeb.Resolvers
  import AbsintheErrorPayload.Payload
  import Absinthe.Resolution.Helpers

  @desc "A comment."
  object :comment do
    field :id, non_null(:id)
    field :content, non_null(:string)
    field :inserted_at, non_null(:datetime)
    field :updated_at, non_null(:datetime)
    field :author, non_null(:user) do
      resolve dataloader(Taskerito.Repo)
    end
  end

  input_object :comment_input do
    field :content, :string
  end

  payload_object(:comment_payload, :comment)

  object :comment_queries do
  end

  object :comment_mutations do
    field :create_comment, non_null(:comment_payload) do
      arg :task_id, non_null(:id)
      arg :input, non_null(:comment_input)
      resolve &Resolvers.Comments.create_comment/3
      middleware &build_payload/2
    end

    field :update_comment, non_null(:comment_payload) do
      arg :id, non_null(:id)
      arg :input, non_null(:comment_input)
      resolve &Resolvers.Comments.update_comment/3
      middleware &build_payload/2
    end
  end
end
