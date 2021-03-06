defmodule TaskeritoWeb.Resolvers.Projects do
  alias Taskerito.Projects.Projects

  def can_manage(project, _args, %{context: %{current_user: current_user}}) do
    {:ok, Projects.can_manage_project(project, current_user)}
  end

  def can_manage(_parent, _args, _resolution), do: {:ok, false}

  def list_projects(_parent, %{order_by: order_by}, _resolution) do
    {:ok, Projects.list_projects(%{order_by: order_by})}
  end

  def get_project(_parent, %{id: id}, _resolution) do
    {:ok, Projects.get_project(id)}
  end

  def create_project(_parent, %{input: input}, %{context: %{current_user: current_user}}) do
    Projects.create_project(current_user, input)
  end

  def create_project(_parent, _args, _resolution), do: {:error, :not_authorized}

  def update_project(_parent, %{id: id, input: input}, %{context: %{current_user: current_user}}) do
    project = Projects.get_project!(id)

    if Projects.can_manage_project(project, current_user) do
      Projects.update_project(project, input)
    else
      {:error, :not_authorized}
    end
  end

  def update_project(_parent, _args, _resolution), do: {:error, :not_authorized}
end
