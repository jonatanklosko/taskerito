defmodule TaskeritoWeb.Resolvers.Projects do
  alias Taskerito.Projects

  def list_projects(_parent, _args, _resolution) do
    {:ok, Projects.list_projects()}
  end

  def get_project(_parent, %{id: id}, _resolution) do
    {:ok, Projects.get_project(id)}
  end

  def create_project(_parent, %{input: input}, %{context: %{current_user: user}}) do
    Projects.create_project(user, input)
  end

  def create_project(_parent, _args, _resolution), do: {:error, :not_authorized}

  def update_project(_parent, %{id: id, input: input}, %{context: %{current_user: user}}) do
    project = Projects.get_project!(id)
    if project.author_id === user.id do
      Projects.update_project(project, input)
    else
      {:error, :not_authorized}
    end
  end

  def update_project(_parent, _args, _resolution), do: {:error, :not_authorized}
end
