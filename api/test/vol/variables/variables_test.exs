defmodule Vol.VariablesTest do
  use Vol.DataCase

  alias Vol.Variables

  describe "variables" do
    alias Vol.Variables.Variable

    @valid_attrs %{uid: "some uid", value: "some value"}
    @update_attrs %{uid: "some updated uid", value: "some updated value"}
    @invalid_attrs %{uid: nil, value: nil}

    def variable_fixture(attrs \\ %{}) do
      {:ok, variable} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Variables.create_variable()

      variable
    end

    test "list_variables/0 returns all variables" do
      variable = variable_fixture()
      assert Variables.list_variables() == [variable]
    end

    test "get_variable!/1 returns the variable with given id" do
      variable = variable_fixture()
      assert Variables.get_variable!(variable.id) == variable
    end

    test "create_variable/1 with valid data creates a variable" do
      assert {:ok, %Variable{} = variable} = Variables.create_variable(@valid_attrs)
      assert variable.uid == "some uid"
      assert variable.value == "some value"
    end

    test "create_variable/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Variables.create_variable(@invalid_attrs)
    end

    test "update_variable/2 with valid data updates the variable" do
      variable = variable_fixture()
      assert {:ok, %Variable{} = variable} = Variables.update_variable(variable, @update_attrs)
      assert variable.uid == "some updated uid"
      assert variable.value == "some updated value"
    end

    test "update_variable/2 with invalid data returns error changeset" do
      variable = variable_fixture()
      assert {:error, %Ecto.Changeset{}} = Variables.update_variable(variable, @invalid_attrs)
      assert variable == Variables.get_variable!(variable.id)
    end

    test "delete_variable/1 deletes the variable" do
      variable = variable_fixture()
      assert {:ok, %Variable{}} = Variables.delete_variable(variable)
      assert_raise Ecto.NoResultsError, fn -> Variables.get_variable!(variable.id) end
    end

    test "change_variable/1 returns a variable changeset" do
      variable = variable_fixture()
      assert %Ecto.Changeset{} = Variables.change_variable(variable)
    end
  end
end
