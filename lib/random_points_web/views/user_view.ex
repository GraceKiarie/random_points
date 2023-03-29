defmodule RandomPointsWeb.UserView do
  use RandomPointsWeb, :view
  alias RandomPointsWeb.UserView

  def render("index.json", %{data: data}) do
    %{
      users: render_many(data.users, UserView, "user.json"),
      timestamp: data.timestamp,
      min_number: data.min_number
    }
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      points: user.points
    }
  end
end
