defmodule TaskeritoWeb.Resolvers.Tasks do
  alias Taskerito.Projects

  def list_tasks(_parent, _args, _resolution) do
    {:ok, Projects.list_tasks()}
  end

  def get_task(_parent, %{id: id}, _resolution) do
    {:ok, Projects.get_task(id)}
  end

  def create_task(_parent, %{project_id: proj_id, input: input}, %{context: %{current_user: user}}) do
    project = Projects.get_project!(proj_id)
    if project.author_id === user.id do
      Projects.create_task(user, project, input)
    else
      {:error, :not_authorized}
    end
  end

  def create_task(_parent, _args, _resolution), do: {:error, :not_authorized}

  def update_task(_parent, %{id: id, input: input}, %{context: %{current_user: user}}) do
    task = Projects.get_task!(id)
    if task.author_id === user.id do
      Projects.update_task(task, input)
    else
      {:error, :not_authorized}
    end
  end

  def update_task(_parent, _args, _resolution), do: {:error, :not_authorized}

  def finish_task(_parent, %{id: id}, %{context: %{current_user: user}}) do
    task = Projects.get_task!(id)
    cond do
      task.finished_at != nil -> {:error, :already_finished}
      task.author_id !== user.id -> {:error, :not_authorized}
      true -> Projects.finish_task(task)
    end
  end

  def finish_task(_parent, _args, _resolution), do: {:error, :not_authorized}
end
