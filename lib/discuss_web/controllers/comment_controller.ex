defmodule DiscussWeb.CommentController do
  use DiscussWeb, :controller

  import Ecto
  alias Discuss.Discussions
  alias Discuss.Discussions.Comment

  plug Discuss.Plugs.Verify when action in [:new, :create, :edit, :update, :delete]

  def index(conn, _params) do
    comments = Discussions.list_comments()
    render(conn, :index, comments: comments)
  end

  def new(conn, _params) do
    changeset = Discussions.change_comment(%Comment{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"comment" => comment_params}) do
    changeset =
      conn.assigns.current_user
      |> build_assoc(:comments)
      |> Comment.changeset(comment_params)
    case Discuss.Repo.insert(changeset) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: ~p"/comments/#{comment}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Discussions.get_comment!(id)
    render(conn, :show, comment: comment)
  end

  def edit(conn, %{"id" => id}) do
    comment = Discussions.get_comment!(id)
    changeset = Discussions.change_comment(comment)
    render(conn, :edit, comment: comment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Discussions.get_comment!(id)

    case Discussions.update_comment(comment, comment_params) do
      {:ok, comment} ->
        IO.puts("comment_params: #{inspect(comment_params)}")
        conn
        |> put_flash(:info, "Comment updated successfully.")
        |> redirect(to: ~p"/comments/#{comment}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, comment: comment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Discussions.get_comment!(id)
    {:ok, _comment} = Discussions.delete_comment(comment)

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: ~p"/comments")
  end
end
