defmodule TweeterWeb.PostLive.PostComponent do
  use TweeterWeb, :live_component

  alias Tweeter.Timeline

  @impl true
  def handle_event("like", _, socket) do
    Timeline.inc_likes(socket.assigns.post)
    {:noreply, socket}
  end

  @impl true
  def handle_event("repost", _, socket) do
    Timeline.inc_reposts(socket.assigns.post)
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~L"""
      <div id="post-<%= @post.id %>"
           class="post <%= if @post.__meta__.state == :deleted do %>hidden<% end %>">
        <div class="row">
          <div class="column column-10">
            <div class="avatar">
              <img src="#" alt="user-image" />
            </div>
          </div>
          <div class="column column-90 post-body">
            <b><%= @post.username %></b>
            <br />
            <%= @post.body %>
          </div>
        </div>
        <div class="row">
          <div class="column">
            <a href="#" phx-click="like" phx-target="<%= @myself %>">Like:</a>
            <%= @post.likes_count %>
          </div>
          <div class="column">
            <a href="#" phx-click="repost" phx-target="<%= @myself %>">Repost:</a>
            <%= @post.reposts_count %>
          </div>
          <div class="column">
            <span><%= live_redirect "Show", to: Routes.post_show_path(@socket, :show, @post) %></span>
            <span><%= live_patch "Edit", to: Routes.post_index_path(@socket, :edit, @post) %></span>
            <span>
              <%= link "Delete", to: "#",
                                  phx_click: "delete",
                                  phx_value_id: @post.id,
                                  data: [confirm: "Are you sure?"] %>
            </span>
          </div>
        </div>
      </div>
    """
  end
end
