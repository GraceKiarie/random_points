defmodule RandomPoints.AccountsTest do
  use RandomPoints.DataCase

  alias RandomPoints.{Accounts, Accounts.User}

  describe "users" do
    test "list_users/0 returns at max 2 users with points > min_number" do
      min_number = 57
      [12, 89, 70, 16, 99] |> Enum.each(fn points -> create_user(points) end)

      users = Accounts.list_users(min_number)

      user_points = Enum.map(users, fn user -> user.points end)

      assert users |> length == 2
      assert 89 in user_points
      assert 70 in user_points
      assert 99 not in user_points
      assert 12 not in user_points
    end

    test "update_all_users/2 updates all users with random points" do
      user1 = create_user(5)
      user2 = create_user(17)

      assert :ok = Accounts.update_all_users()
    end
  end

  defp create_user(points) do
    RandomPoints.Repo.insert!(%User{points: points})
  end
end
