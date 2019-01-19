defmodule VolWeb.VariableController do
  use VolWeb, :controller

  alias Vol.Variables
  alias Vol.Variables.Variable

  action_fallback VolWeb.FallbackController

  def index(conn, _params) do
    variables = Variables.list_variables()
    render(conn, "index.json", variables: variables)
  end

  def create(conn, %{"variable" => variable_params}) do
    with {:ok, %Variable{} = variable} <- Variables.create_variable(variable_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.variable_path(conn, :show, variable))
      |> render("show.json", variable: variable)
    end
  end

  def show(conn, %{"id" => id}) do
    variable = Variables.get_variable!(id)
    render(conn, "show.json", variable: variable)
  end

  def update(conn, %{"id" => id, "variable" => variable_params}) do
    variable = Variables.get_variable!(id)

    with {:ok, %Variable{} = variable} <- Variables.update_variable(variable, variable_params) do
      render(conn, "show.json", variable: variable)
    end
  end

  def delete(conn, %{"id" => id}) do
    variable = Variables.get_variable!(id)

    with {:ok, %Variable{}} <- Variables.delete_variable(variable) do
      send_resp(conn, :no_content, "")
    end
  end
end
