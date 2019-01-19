defmodule Vol.Variables do
  @moduledoc """
  The Variables context.
  """

  import Ecto.Query, warn: false
  alias Vol.Repo

  alias Vol.Variables.Variable

  @doc """
  Returns the list of variables.

  ## Examples

      iex> list_variables()
      [%Variable{}, ...]

  """
  def list_variables do
    Repo.all(Variable)
  end

  @doc """
  Gets a single variable.

  Raises `Ecto.NoResultsError` if the Variable does not exist.

  ## Examples

      iex> get_variable!(123)
      %Variable{}

      iex> get_variable!(456)
      ** (Ecto.NoResultsError)

  """
  def get_variable!(id), do: Repo.get!(Variable, id)

  @doc """
  Creates a variable.

  ## Examples

      iex> create_variable(%{field: value})
      {:ok, %Variable{}}

      iex> create_variable(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_variable(attrs \\ %{}) do
    %Variable{}
    |> Variable.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a variable.

  ## Examples

      iex> update_variable(variable, %{field: new_value})
      {:ok, %Variable{}}

      iex> update_variable(variable, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_variable(%Variable{} = variable, attrs) do
    variable
    |> Variable.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Variable.

  ## Examples

      iex> delete_variable(variable)
      {:ok, %Variable{}}

      iex> delete_variable(variable)
      {:error, %Ecto.Changeset{}}

  """
  def delete_variable(%Variable{} = variable) do
    Repo.delete(variable)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking variable changes.

  ## Examples

      iex> change_variable(variable)
      %Ecto.Changeset{source: %Variable{}}

  """
  def change_variable(%Variable{} = variable) do
    Variable.changeset(variable, %{})
  end
end
