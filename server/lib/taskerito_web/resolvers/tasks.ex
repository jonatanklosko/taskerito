defmodule TaskeritoWeb.Resolvers.Tasks do
  alias Taskerito.{Projects, Accounts}

  def list_tasks(_parent, _args, _resolution) do
    {:ok, Projects.list_tasks()}
  end

  def get_task(_parent, %{id: id}, _resolution) do
    {:ok, Projects.get_task(id)}
  end

  def create_task(_parent, %{project_id: proj_id, input: input}, %{context: %{current_user: user}}) do
    project = Projects.get_project!(proj_id)
    if Projects.can_manage_project(project, user) do
      Projects.create_task(user, project, input)
    else
      {:error, :not_authorized}
    end
  end

  def create_task(_parent, _args, _resolution), do: {:error, :not_authorized}

  def update_task(_parent, %{id: id, input: input}, %{context: %{current_user: user}}) do
    task = Projects.get_task!(id)
    if Projects.can_manage_task(task, user) do
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
      Projects.can_manage_task(task, user) -> {:error, :not_authorized}
      true -> Projects.finish_task(task)
    end
  end

  def finish_task(_parent, _args, _resolution), do: {:error, :not_authorized}

  def assign_task(_parent, %{id: id, user_id: user_id}, %{context: %{current_user: current_user}}) do
    task = Projects.get_task!(id)
    user = Accounts.get_user!(user_id)
    if Projects.can_manage_task(task, current_user) do
      Projects.assign_task(task, user)
    else
      {:error, :not_authorized}
    end
  end

  def assign_task(_parent, _args, _resolution), do: {:error, :not_authorized}

  def unassign_task(_parent, %{id: id, user_id: user_id}, %{context: %{current_user: current_user}}) do
    task = Projects.get_task!(id)
    user = Accounts.get_user!(user_id)
    if Projects.can_manage_task(task, current_user) do
      Projects.unassign_task(task, user)
    else
      {:error, :not_authorized}
    end
  end

  def unassign_task(_parent, _args, _resolution), do: {:error, :not_authorized}
end
