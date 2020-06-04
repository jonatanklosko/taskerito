defmodule TaskeritoWeb.Resolvers.Comments do
  alias Taskerito.Projects

  def create_comment(_parent, %{task_id: task_id, input: input}, %{context: %{current_user: user}}) do
    task = Projects.get_task!(task_id)
    Projects.create_comment(user, task, input)
  end

  def create_comment(_parent, _args, _resolution), do: {:error, :not_authorized}

  def update_comment(_parent, %{id: id, input: input}, %{context: %{current_user: user}}) do
    comment = Projects.get_comment!(id)
    if Projects.can_manage_comment(comment, user) do
      Projects.update_comment(comment, input)
    else
      {:error, :not_authorized}
    end
  end

  def update_comment(_parent, _args, _resolution), do: {:error, :not_authorized}

  def delete_comment(_parent, %{id: id}, %{context: %{current_user: user}}) do
    comment = Projects.get_comment!(id)
    if Projects.can_manage_comment(comment, user) do
      Projects.delete_comment(comment)
    else
      {:error, :not_authorized}
    end
  end

  def delete_comment(_parent, _args, _resolution), do: {:error, :not_authorized}
end
