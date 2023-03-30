defmodule RandomPoints.Seeds do
  alias RandomPoints.Accounts.User

  @range 0..100

  def run! do
    1..1_000_000
    |> Enum.each(fn -> RandomPoints.Repo.insert!(%User{points: @range |> Enum.random()}) end)
  end
end
