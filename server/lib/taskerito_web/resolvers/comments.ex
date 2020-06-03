defmodule TaskeritoWeb.Resolvers.Comments do
  alias Taskerito.Projects

  def create_comment(_parent, %{task_id: task_id, input: input}, %{context: %{current_user: user}}) do
    task = Projects.get_task!(task_id)
    if task.author_id === user.id do
      Projects.create_comment(user, task, input)
    else
      {:error, :not_authorized}
    end
  end

  def create_comment(_parent, _args, _resolution), do: {:error, :not_authorized}

  def update_comment(_parent, %{id: id, input: input}, %{context: %{current_user: user}}) do
    comment = Projects.get_comment!(id)
    if comment.author_id === user.id do
      Projects.update_comment(comment, input)
    else
      {:error, :not_authorized}
    end
  end

  def update_comment(_parent, _args, _resolution), do: {:error, :not_authorized}
end
