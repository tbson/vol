defmodule VolWeb.VariableView do
  use VolWeb, :view
  alias VolWeb.VariableView

  def render("index.json", %{variables: variables}) do
    %{data: render_many(variables, VariableView, "variable.json")}
  end

  def render("show.json", %{variable: variable}) do
    %{data: render_one(variable, VariableView, "variable.json")}
  end

  def render("variable.json", %{variable: variable}) do
    %{id: variable.id,
      uid: variable.uid,
      value: variable.value}
  end
end
