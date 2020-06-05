defmodule Taskerito.Accounts.UsersTest do
  use Taskerito.DataCase

  alias Taskerito.Accounts.Users
  alias Taskerito.Accounts.User

  import Taskerito.Factory

  @valid_attrs %{email: "some email", name: "some name", username: "some username", password: "password"}
  @update_attrs %{email: "some updated email", name: "some updated name", username: "some updated username"}
  @invalid_attrs %{email: nil, name: nil, username: nil}

  test "list_users/0 returns all users" do
    users = insert_list(5, :user)
    actual_user_ids = Users.list_users() |> Enum.map(&(&1.id))
    expected_user_ids = users |> Enum.map(&(&1.id))
    assert actual_user_ids == expected_user_ids
  end

  test "get_user!/1 returns the user with given id" do
    user = insert(:user)
    assert Users.get_user!(user.id).id == user.id
  end

  test "create_user/1 with valid data creates a user" do
    assert {:ok, %User{} = user} = Users.create_user(@valid_attrs)
    assert user.email == "some email"
    assert user.name == "some name"
    assert user.username == "some username"
  end

  test "create_user/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
  end

  test "update_user/2 with valid data updates the user" do
    user = insert(:user)
    assert {:ok, %User{} = user} = Users.update_user(user, @update_attrs)
    assert user.email == "some updated email"
    assert user.name == "some updated name"
    assert user.username == "some updated username"
  end

  test "update_user/2 with invalid data returns error changeset" do
    user = insert(:user)
    assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
    assert user.id == Users.get_user!(user.id).id
  end

  test "delete_user/1 deletes the user" do
    user = insert(:user)
    assert {:ok, %User{}} = Users.delete_user(user)
    assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
  end

  test "change_user/1 returns a user changeset" do
    user = build(:user)
    assert %Ecto.Changeset{} = Users.change_user(user)
  end
end
