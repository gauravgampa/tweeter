defmodule TweeterWeb.PostLive.PostComponent do
  use TweeterWeb, :live_component

  @impl true
  def render(assigns) do
    ~L"""
      <div id="post-<%= @post.id %>" class="post">
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
            <a href="#">Like:</a>
            <%= @post.likes_count %>
          </div>
          <div class="column">
            <a href="#">Repost:</a>
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
