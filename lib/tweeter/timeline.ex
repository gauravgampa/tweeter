defmodule Tweeter.Timeline do
  @moduledoc """
  The Timeline context.
  """

  import Ecto.Query, warn: false
  alias Tweeter.Repo

  alias Tweeter.Timeline.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(from p in Post, order_by: [desc: p.id])
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(%Post{} = post, attrs \\ %{}, after_save \\ &{:ok, &1}) do
    post
    |> Post.changeset(attrs)
    |> Repo.insert()
    |> after_save(after_save)
    |> broadcast(:post_created)
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs,  after_save \\ &{:ok, &1}) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
    |> after_save(after_save)
    |> broadcast(:post_updated)
  end

  def after_save({:ok, post}, func) do
    {:ok, _post} = func.(post)
  end

  def after_save(error, _func), do: error

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    post
    |> Repo.delete()
    |> broadcast(:post_deleted)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  def inc_likes(%Post{} = post) do
    update_post(post, %{likes_count: post.likes_count + 1})
  end

  def inc_reposts(%Post{} = post) do
    update_post(post, %{reposts_count: post.reposts_count + 1})
  end

  def subscribe() do
    Phoenix.PubSub.subscribe(Tweeter.PubSub, "posts")
  end

  def broadcast({:error, _reason} = error, _event), do: error
  def broadcast({:ok, post} = error, event) do
    Phoenix.PubSub.broadcast(Tweeter.PubSub, "posts", {event, post})
    {:ok, post}
  end
end
