defmodule TaskeritoWeb.Schema.ProjectTypes do
  use Absinthe.Schema.Notation

  alias TaskeritoWeb.Resolvers
  import AbsintheErrorPayload.Payload
  import Absinthe.Resolution.Helpers

  @desc "A project."
  object :project do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :description, non_null(:string)
    field :author, non_null(:user) do
      resolve dataloader(Taskerito.Repo)
    end
  end

  input_object :project_input do
    field :name, :string
    field :description, :string
  end

  payload_object(:project_payload, :project)

  object :project_queries do
    field :projects, non_null(list_of(non_null(:project))) do
      resolve &Resolvers.Projects.list_projects/3
    end
  end

  object :project_mutations do
    field :create_project, non_null(:project_payload) do
      arg :input, non_null(:project_input)
      resolve &Resolvers.Projects.create_project/3
      middleware &build_payload/2
    end

    field :update_project, non_null(:project_payload) do
      arg :id, non_null(:id)
      arg :input, non_null(:project_input)
      resolve &Resolvers.Projects.update_project/3
      middleware &build_payload/2
    end
  end
end
