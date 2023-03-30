defmodule RandomPointsWeb.UserController do
  use RandomPointsWeb, :controller

  alias RandomPoints.Randomizer

  action_fallback RandomPointsWeb.FallbackController

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    data = Randomizer.get_users(Randomizer)
    render(conn, "index.json", %{data: data})
  end
end
