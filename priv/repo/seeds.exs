defmodule RandomPoints.Seeds do
  alias RandomPoints.Accounts.User

  @range 0..100

  def run! do
    1..10
    |> Enum.each(fn _ -> RandomPoints.Repo.insert!(%User{points: @range |> Enum.random()}) end)
  end
end
