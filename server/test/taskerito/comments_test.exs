defmodule Taskerito.CommentsTest do
  use Taskerito.DataCase

  alias Taskerito.Projects.{Comment, Comments}

  import Taskerito.Factory

  @valid_attrs %{content: "some content"}
  @update_attrs %{content: "some updated content"}
  @invalid_attrs %{content: nil}

  test "list_comments/0 returns all comments" do
    comments = insert_list(5, :comment)
    actual_comment_ids = Comments.list_comments() |> Enum.map(&(&1.id))
    expected_comment_ids = comments |> Enum.map(&(&1.id))
    assert actual_comment_ids == expected_comment_ids
  end

  test "get_comment!/1 returns the comment with given id" do
    comment = insert(:comment)
    assert Comments.get_comment!(comment.id).id == comment.id
  end

  test "create_comment/1 with valid data creates a comment" do
    author = insert(:user)
    task = insert(:task)
    assert {:ok, %Comment{} = comment} = Comments.create_comment(author, task, @valid_attrs)
    assert comment.content == "some content"
    assert comment.author_id == author.id
    assert comment.task_id == task.id
  end

  test "create_comment/1 with invalid data returns error changeset" do
    author = insert(:user)
    task = insert(:task)
    assert {:error, %Ecto.Changeset{}} = Comments.create_comment(author, task, @invalid_attrs)
  end

  test "update_comment/2 with valid data updates the comment" do
    comment = insert(:comment)
    assert {:ok, %Comment{} = comment} = Comments.update_comment(comment, @update_attrs)
    assert comment.content == "some updated content"
  end

  test "update_comment/2 with invalid data returns error changeset" do
    comment = insert(:comment)
    assert {:error, %Ecto.Changeset{}} = Comments.update_comment(comment, @invalid_attrs)
    assert comment.id == Comments.get_comment!(comment.id).id
  end

  test "delete_comment/1 deletes the comment" do
    comment = insert(:comment)
    assert {:ok, %Comment{}} = Comments.delete_comment(comment)
    assert_raise Ecto.NoResultsError, fn -> Comments.get_comment!(comment.id) end
  end

  test "change_comment/1 returns a comment changeset" do
    comment = build(:comment)
    assert %Ecto.Changeset{} = Comments.change_comment(comment)
  end
end
