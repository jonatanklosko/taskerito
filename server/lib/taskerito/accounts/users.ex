defmodule Taskerito.Accounts.Users do
  @moduledoc """
  The module for User management.
  """

  import Ecto.Query, warn: false
  alias Taskerito.Repo

  alias Taskerito.Accounts.User

  @doc """
  Returns the list of users.
  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.
  """
  def get_user!(id), do: Repo.get!(User, id)

  def get_user(id), do: Repo.get(User, id)

  @doc """
  Creates a user.
  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.sign_up_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.
  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.
  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.
  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  @doc """
  Gets a user by username and authenticates him by password.
  """
  @spec authenticate_by_username_password(String.t(), String.t()) ::
          {:ok, %User{}} | {:error, term}
  def authenticate_by_username_password(username, password) do
    case Repo.get_by(User, username: username) do
      nil -> {:error, :not_found}
      user -> Argon2.check_pass(user, password)
    end
  end
end
