defmodule TaskeritoWeb.Schema.TaskTypes do
  use Absinthe.Schema.Notation

  alias TaskeritoWeb.Resolvers
  import AbsintheErrorPayload.Payload
  import Absinthe.Resolution.Helpers

  @desc "A task."
  object :task do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :description, non_null(:string)
    field :priority, non_null(:integer)
    field :inserted_at, non_null(:datetime)
    field :updated_at, non_null(:datetime)
    field :finished_at, :datetime
    field :author, non_null(:user) do
      resolve dataloader(Taskerito.Repo)
    end
    field :project, non_null(:project) do
      resolve dataloader(Taskerito.Repo)
    end
    field :comments, non_null(list_of(non_null(:comment))) do
      resolve dataloader(Taskerito.Repo)
    end
  end

  input_object :task_input do
    field :name, :string
    field :description, :string
    field :priority, :integer
  end

  payload_object(:task_payload, :task)

  object :task_queries do
    field :tasks, non_null(list_of(non_null(:task))) do
      resolve &Resolvers.Tasks.list_tasks/3
    end

    field :task, :task do
      arg :id, non_null(:id)
      resolve &Resolvers.Tasks.get_task/3
    end
  end

  object :task_mutations do
    field :create_task, non_null(:task_payload) do
      arg :project_id, non_null(:id)
      arg :input, non_null(:task_input)
      resolve &Resolvers.Tasks.create_task/3
      middleware &build_payload/2
    end

    field :update_task, non_null(:task_payload) do
      arg :id, non_null(:id)
      arg :input, non_null(:task_input)
      resolve &Resolvers.Tasks.update_task/3
      middleware &build_payload/2
    end

    field :finish_task, non_null(:task_payload) do
      arg :id, non_null(:id)
      resolve &Resolvers.Tasks.finish_task/3
      middleware &build_payload/2
    end
  end
end
