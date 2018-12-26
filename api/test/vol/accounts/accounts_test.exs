defmodule Vol.AccountsTest do
  use Vol.DataCase

  alias Vol.Accounts
  import Comeonin.Argon2, only: [checkpw: 2, dummy_checkpw: 0]

  describe "users" do
    alias Vol.Accounts.User

    @valid_attrs %{
      firstname: "some firstname",
      lastname: "some lastname",
      middlename: "some middlename",
      credential: %{
        email: "email@provider.com",
        password: "some password"
      }
    }
    @update_attrs %{
      firstname: "some updated firstname",
      lastname: "some updated lastname",
      middlename: "some updated middlename"
    }
    @invalid_attrs %{firstname: nil, lastname: nil, middlename: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    def user_filter(item) do
      %{id: item.id, firstname: item.firstname, lastname: item.lastname}
    end

    def credential_filter(item) do
      %{id: item.id, email: item.email, password_hash: item.password_hash}
    end

    test "list_users/0 returns all users" do
      user = user_fixture()

      users =
        [user]
        |> Enum.map(&user_filter(&1))

      assert Enum.map(Accounts.list_users(), &user_filter(&1)) == users
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert user_filter(Accounts.get_user!(user.id)) == user_filter(user)
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.firstname == "some firstname"
      assert user.lastname == "some lastname"
      assert user.middlename == "some middlename"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.firstname == "some updated firstname"
      assert user.lastname == "some updated lastname"
      assert user.middlename == "some updated middlename"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user_filter(user) == user_filter(Accounts.get_user!(user.id))
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "credentials" do
    alias Vol.Accounts.Credential

    @valid_attrs %{email: "some email", password: "some password"}
    @update_attrs %{email: "some updated email", password: "some updated password"}
    @invalid_attrs %{email: nil, password_hash: nil}

    def credential_fixture(attrs \\ %{}) do
      {:ok, credential} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_credential()

      credential
    end

    test "list_credentials/0 returns all credentials" do
      credential = credential_fixture()

      credentials =
        [credential]
        |> Enum.map(&credential_filter(&1))

      assert Enum.map(Accounts.list_credentials(), &credential_filter(&1)) == credentials
    end

    test "get_credential!/1 returns the credential with given id" do
      credential = credential_filter(credential_fixture())
      assert credential_filter(Accounts.get_credential!(credential.id)) == credential
    end

    test "create_credential/1 with valid data creates a credential" do
      assert {:ok, %Credential{} = credential} = Accounts.create_credential(@valid_attrs)
      assert credential.email == "some email"
      assert checkpw("some password", credential.password_hash)
    end

    test "create_credential/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_credential(@invalid_attrs)
    end

    test "update_credential/2 with valid data updates the credential" do
      credential = credential_fixture()

      assert {:ok, %Credential{} = credential} =
               Accounts.update_credential(credential, @update_attrs)

      assert credential.email == "some updated email"
    end

    test "update_credential/2 with invalid data returns error changeset" do
      credential = credential_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_credential(credential, @invalid_attrs)

      assert credential_filter(credential) ==
               credential_filter(Accounts.get_credential!(credential.id))
    end

    test "delete_credential/1 deletes the credential" do
      credential = credential_fixture()
      assert {:ok, %Credential{}} = Accounts.delete_credential(credential)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_credential!(credential.id) end
    end

    test "change_credential/1 returns a credential changeset" do
      credential = credential_fixture()
      assert %Ecto.Changeset{} = Accounts.change_credential(credential)
    end
  end
end
