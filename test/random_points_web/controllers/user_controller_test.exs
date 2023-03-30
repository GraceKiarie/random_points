defmodule RandomPointsWeb.UserControllerTest do
  use RandomPointsWeb.ConnCase
  alias RandomPoints.Accounts.User

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["users"] == []
      assert json_response(conn, 200)["timestamp"] == nil
    end
  end
end
