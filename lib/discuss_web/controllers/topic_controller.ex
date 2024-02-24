defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  import Ecto
  alias Discuss.Discussions
  alias Discuss.Discussions.Topic

  plug Discuss.Plugs.Verify when action in [:new, :create, :edit, :update, :delete, :show]

  plug :check_topic_owner, when: [:edit, :update, :delete]

  def index(conn, _params) do
    topics = Discussions.list_topics()
    render(conn, :index, topics: topics)
  end

  def new(conn, _params) do
    changeset = Discussions.change_topic(%Topic{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"topic" => topic_params}) do
    changeset =
      conn.assigns.current_user
      |> build_assoc(:topics)
      |> Topic.changeset(topic_params)

    case Discuss.Repo.insert(changeset) do
      {:ok, topic} ->
        conn
        |> put_session("topic_id", topic.id)
        |> put_flash(:info, "Topic created successfully.")
        |> redirect(to: ~p"/topics/#{topic}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    topic = Discussions.get_topic!(id)
    comment = List.first(Discussions.get_user_comments_by_user_id(conn.assigns.current_user.id))
    IO.inspect(comment, label: "comment")
    render(conn, :show, %{topic: topic, comment: comment})
  end

  def edit(conn, %{"id" => id}) do
    topic = Discussions.get_topic!(id)
    changeset = Discussions.change_topic(topic)
    render(conn, :edit, topic: topic, changeset: changeset)
  end

  def update(conn, %{"id" => id, "topic" => topic_params}) do
    topic = Discussions.get_topic!(id)

    case Discussions.update_topic(topic, topic_params) do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic updated successfully.")
        |> redirect(to: ~p"/topics/#{topic}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, topic: topic, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    topic = Discussions.get_topic!(id)
    {:ok, _topic} = Discussions.delete_topic(topic)

    conn
    |> put_flash(:info, "Topic deleted successfully.")
    |> redirect(to: ~p"/topics")
  end

  import Discuss.Repo

  def check_topic_owner(conn, _params) do
    IO.inspect(Map.get(conn.params, :id), label: "conn.params")
    if Map.get(conn.params, :id) == nil do
      conn
    else
      {post_id, _} = Integer.parse(Map.get(conn.params, :id))

      try do
        topic = get(Topic, post_id)

        if !is_nil(topic) && topic.users_id != conn.assigns.current_user.id do
          conn
          |> put_flash(:error, "You are not authorized to perform this action on topic.")
          |> redirect(to: "/topics/")
          |> halt()
        else
          conn
        end
      rescue
        Ecto.NoResultsError ->
          conn
          |> put_flash(:error, "Topic not found.")
          |> redirect(to: "/topics/")
      catch
        Ecto.NoResultsError ->
          conn
          |> put_flash(:error, "Topic not found.")
          |> redirect(to: "/topics/")
      end
    end
  end
end
