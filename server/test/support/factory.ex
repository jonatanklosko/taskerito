defmodule Taskerito.Factory do
  use ExMachina.Ecto, repo: Taskerito.Repo

  def user_factory do
    %Taskerito.Accounts.User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      name: "Sherlock Holmes",
      username: sequence(:username, &"shlomes#{&1}"),
      password_hash: "whatever hash"
    }
  end

  def set_password(user, password) do
    user
    |> Taskerito.Accounts.User.sign_up_changeset(%{password: password})
    |> Ecto.Changeset.apply_changes()
  end

  def project_factory do
    %Taskerito.Projects.Project{
      description: "Some description.",
      name: "Important project",
      author: build(:user)
    }
  end

  def task_factory do
    %Taskerito.Projects.Task{
      description: "Some description.",
      name: "Important task",
      priority: 1,
      author: build(:user),
      project: build(:project)
    }
  end

  def comment_factory do
    %Taskerito.Projects.Comment{
      content: "My two cents.",
      author: build(:user),
      task: build(:task)
    }
  end
end
