defmodule TaskeritoWeb.Resolvers.Comments do
  alias Taskerito.Projects.{Tasks, Comments}

  def create_comment(_parent, %{task_id: task_id, input: input}, %{context: %{current_user: current_user}}) do
    task = Tasks.get_task!(task_id)
    Comments.create_comment(current_user, task, input)
  end

  def create_comment(_parent, _args, _resolution), do: {:error, :not_authorized}

  def update_comment(_parent, %{id: id, input: input}, %{context: %{current_user: current_user}}) do
    comment = Comments.get_comment!(id)
    if Comments.can_manage_comment(comment, current_user) do
      Comments.update_comment(comment, input)
    else
      {:error, :not_authorized}
    end
  end

  def update_comment(_parent, _args, _resolution), do: {:error, :not_authorized}

  def delete_comment(_parent, %{id: id}, %{context: %{current_user: current_user}}) do
    comment = Comments.get_comment!(id)
    if Comments.can_manage_comment(comment, current_user) do
      Comments.delete_comment(comment)
    else
      {:error, :not_authorized}
    end
  end

  def delete_comment(_parent, _args, _resolution), do: {:error, :not_authorized}
end
