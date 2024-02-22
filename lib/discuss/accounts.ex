defmodule Discuss.Accounts do

  defstruct [:github]

  use DiscussWeb, :controller
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  import Phoenix.Controller

  alias Discuss.Repo

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%Users{}, ...]

  """
  def list_users do
        Repo.all(Users)
  end

  @doc """
  Gets a single users.

  Raises `Ecto.NoResultsError` if the Users does not exist.

  ## Examples

    iex> get_users!(123)
    %Users{}

    iex> get_users!(456)
    ** (Ecto.NoResultsError)

  """
  def get_users!(id), do: Repo.get!(Users, id)

      @doc """
      Creates a users.

      ## Examples

          iex> create_users(%{field: value})
          {:ok, %Users{}}

          iex> create_users(%{field: bad_value})
          {:error, %Ecto.Changeset{}}

      """
      def create_users(attrs \\ %{}) do
        %Users{}
        |> Users.changeset(attrs)
        |> Repo.insert()
      end

      @doc """
      Updates a users.

      ## Examples

          iex> update_users(users, %{field: new_value})
          {:ok, %Users{}}

          iex> update_users(users, %{field: bad_value})
          {:error, %Ecto.Changeset{}}

      """
      def update_users(%Users{} = users, attrs) do
        users
        |> Users.changeset(attrs)
        |> Repo.update()
      end

      @doc """
      Deletes a users.

      ## Examples

          iex> delete_users(users)
          {:ok, %Users{}}

          iex> delete_users(users)
          {:error, %Ecto.Changeset{}}

      """
      def delete_users(%Users{} = users) do
        Repo.delete(users)
      end

      @doc """
      Returns an `%Ecto.Changeset{}` for tracking users changes.

      ## Examples

          iex> change_users(users)
          %Ecto.Changeset{data: %Users{}}

      """
      def change_users(%Users{} = users, attrs \\ %{}) do
        Users.changeset(users, attrs)
      end

      def get_user_by_id(id) do
        Repo.get(Users, id)
      end



      def get_or_create_user(%{email: email, nickname: nickname}) do
        case get_user_by_email(email) do
          nil ->
            case create_user(email, nickname) do
              {:ok, user} -> {:ok, user}
              {:error, reason} -> {:error, reason}
            end

          {:error, reason} ->
            {:error, reason}

          user ->
            {:ok, user}
        end
      end

      def create_user(%{"email" => email, "nickname" => nickname}) do
        %Users{}
        |> Users.changeset(%{email: email, nickname: nickname})
        |> Repo.insert()
      end

      def get_user_by_email(email) do
        Repo.get_by(Users, email: email)
      end
end
