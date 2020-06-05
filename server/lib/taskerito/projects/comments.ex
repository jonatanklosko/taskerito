defmodule Taskerito.Projects.Comments do
  @moduledoc """
  The module for Comment management.
  """

  import Ecto.Query, warn: false
  alias Taskerito.Repo
  alias Taskerito.Projects.{Task, Comment}
  alias Taskerito.Accounts.User

  @doc """
  Returns the list of comments.
  """
  def list_comments do
    Repo.all(Comment)
  end

  @doc """
  Gets a single comment.

  Raises `Ecto.NoResultsError` if the Comment does not exist.
  """
  def get_comment!(id), do: Repo.get!(Comment, id)

  @doc """
  Creates a comment.
  """
  def create_comment(%User{} = author, %Task{} = task, attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Ecto.Changeset.put_change(:author_id, author.id)
    |> Ecto.Changeset.put_change(:task_id, task.id)
    |> Repo.insert()
  end

  @doc """
  Updates a comment.
  """
  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a comment.
  """
  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking comment changes.
  """
  def change_comment(%Comment{} = comment, attrs \\ %{}) do
    Comment.changeset(comment, attrs)
  end

  @doc """
  Returns whether a user can manage a comment.
  """
  def can_manage_comment(%Comment{} = comment, %User{} = user) do
    comment.author_id == user.id
  end
end
