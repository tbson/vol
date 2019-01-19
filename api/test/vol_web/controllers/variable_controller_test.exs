defmodule VolWeb.VariableControllerTest do
  use VolWeb.ConnCase

  alias Vol.Accounts
  alias Vol.Variables
  alias Vol.Variables.Variable

  @credential_attrs %{
    firstname: "test",
    lastname: "test",
    credential: %{
      email: "test@test.com",
      password: "test123"
    }
  }

  @create_attrs %{
    uid: "some uid",
    value: "some value"
  }
  @update_attrs %{
    uid: "some updated uid",
    value: "some updated value"
  }
  @invalid_attrs %{uid: nil, value: nil}

  def fixture(:variable) do
    {:ok, variable} = Variables.create_variable(@create_attrs)
    variable
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
    test "lists all variables", %{conn: conn} do
      conn = get(conn, Routes.variable_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create variable" do
    test "renders variable when data is valid", %{conn: conn} do
      conn = post(conn, Routes.variable_path(conn, :create), variable: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.variable_path(conn, :show, id))

      assert %{
               "id" => id,
               "uid" => "some uid",
               "value" => "some value"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.variable_path(conn, :create), variable: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update variable" do
    setup [:create_variable]

    test "renders variable when data is valid", %{
      conn: conn,
      variable: %Variable{id: id} = variable
    } do
      conn = put(conn, Routes.variable_path(conn, :update, variable), variable: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.variable_path(conn, :show, id))

      assert %{
               "id" => id,
               "uid" => "some updated uid",
               "value" => "some updated value"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, variable: variable} do
      conn = put(conn, Routes.variable_path(conn, :update, variable), variable: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete variable" do
    setup [:create_variable]

    test "deletes chosen variable", %{conn: conn, variable: variable} do
      conn = delete(conn, Routes.variable_path(conn, :delete, variable))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, Routes.variable_path(conn, :show, variable))
      end)
    end
  end

  defp create_variable(_) do
    variable = fixture(:variable)
    {:ok, variable: variable}
  end
end
