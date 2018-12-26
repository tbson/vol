defmodule VolWeb.UserControllerTest do
  use VolWeb.ConnCase

  alias Vol.Accounts
  alias Vol.Accounts.User

  @credential_attrs %{
    firstname: "test",
    lastname: "test",
    credential: %{
      email: "test@test.com",
      password: "test123"
    }
  }

  @create_attrs %{
    firstname: "some firstname",
    lastname: "some lastname",
    middlename: "some middlename",
    credential: %{
      email: "user1@test.com",
      password: "test123"
    }
  }
  @update_attrs %{
    firstname: "some updated firstname",
    lastname: "some updated lastname",
    middlename: "some updated middlename"
  }
  @invalid_attrs %{firstname: nil, lastname: nil, middlename: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  def fixture(:credential) do
    Accounts.create_user(@credential_attrs)
    %{token: {:ok, token, _}} = Accounts.token_auth("test@test.com", "test123")
    token
  end

  setup %{conn: conn} do
    token = "Bearer " <> fixture(:credential)

    conn =
      conn
      |> put_req_header("accept", "application/json")
      |> put_req_header("authorization", token)

    {:ok, conn: conn}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      result = json_response(conn, 200)["data"]
      [auth_user | _] = result
      assert Enum.count(result) == 1
      assert auth_user["firstname"] === "test"
      assert auth_user["lastname"] === "test"
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "firstname" => "some firstname",
               "lastname" => "some lastname",
               "middlename" => "some middlename"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "firstname" => "some updated firstname",
               "lastname" => "some updated lastname",
               "middlename" => "some updated middlename"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end)
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
