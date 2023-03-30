defmodule RandomPoints.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false

  alias RandomPoints.Accounts.User
  alias RandomPoints.Repo

  @spec list_users(any) :: any
  def list_users(min_number) do
    User |> where([u], u.points > ^min_number) |> limit(2) |> Repo.all()
  end

  @spec update_all_users :: :ok
  def update_all_users() do
    users = Repo.all(User)

    Enum.each(users, fn user ->
      user
      |> User.changeset(%{points: Enum.random(1..100)})
      |> Repo.update()
    end)
  end
end
