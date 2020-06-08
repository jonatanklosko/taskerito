defmodule TaskeritoWeb.Resolvers.Tasks do
  alias Taskerito.Projects.{Projects, Tasks}
  alias Taskerito.Accounts.Users

  def can_manage(task, _args, %{context: %{current_user: current_user}}) do
    {:ok, Tasks.can_manage_task(task, current_user)}
  end

  def can_manage(_parent, _args, _resolution), do: {:ok, false}

  def list_tasks(_parent, %{order_by: order_by}, _resolution) do
    {:ok, Tasks.list_tasks(%{order_by: order_by})}
  end

  def get_task(_parent, %{id: id}, _resolution) do
    {:ok, Tasks.get_task(id)}
  end

  def create_task(_parent, %{project_id: proj_id, input: input}, %{
        context: %{current_user: current_user}
      }) do
    project = Projects.get_project!(proj_id)

    if Projects.can_manage_project(project, current_user) do
      Tasks.create_task(current_user, project, input)
    else
      {:error, :not_authorized}
    end
  end

  def create_task(_parent, _args, _resolution), do: {:error, :not_authorized}

  def update_task(_parent, %{id: id, input: input}, %{context: %{current_user: current_user}}) do
    task = Tasks.get_task!(id)

    if Tasks.can_manage_task(task, current_user) do
      Tasks.update_task(task, input)
    else
      {:error, :not_authorized}
    end
  end

  def update_task(_parent, _args, _resolution), do: {:error, :not_authorized}

  def finish_task(_parent, %{id: id}, %{context: %{current_user: current_user}}) do
    task = Tasks.get_task!(id)

    cond do
      task.finished_at != nil -> {:error, :already_finished}
      !Tasks.can_manage_task(task, current_user) -> {:error, :not_authorized}
      true -> Tasks.finish_task(task)
    end
  end

  def finish_task(_parent, _args, _resolution), do: {:error, :not_authorized}

  def unfinish_task(_parent, %{id: id}, %{context: %{current_user: current_user}}) do
    task = Tasks.get_task!(id)

    if Tasks.can_manage_task(task, current_user) do
      Tasks.unfinish_task(task)
    else
      {:error, :not_authorized}
    end
  end

  def finish_task(_parent, _args, _resolution), do: {:error, :not_authorized}

  def assign_task(_parent, %{id: id, user_id: user_id}, %{context: %{current_user: current_user}}) do
    task = Tasks.get_task!(id)
    user = Users.get_user!(user_id)

    if Tasks.can_manage_task(task, current_user) do
      Tasks.assign_task(task, user)
    else
      {:error, :not_authorized}
    end
  end

  def assign_task(_parent, _args, _resolution), do: {:error, :not_authorized}

  def unassign_task(_parent, %{id: id, user_id: user_id}, %{
        context: %{current_user: current_user}
      }) do
    task = Tasks.get_task!(id)
    user = Users.get_user!(user_id)

    if Tasks.can_manage_task(task, current_user) do
      Tasks.unassign_task(task, user)
    else
      {:error, :not_authorized}
    end
  end

  def unassign_task(_parent, _args, _resolution), do: {:error, :not_authorized}
end
