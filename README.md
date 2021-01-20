# Tweeter

Twitter clone to understand concepts of phoenix liveview

Steps to setup:

- mix phx.new <app_name> --live
- mix phx.gen.live Timeline Post posts username body likes_count:integer repos_count:integer
  (Bootstrap a CRUD liveview)
- mix ecto.create (creating DB)
- mix ecto.migrate (migrating DB)

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Install Node.js dependencies with `npm install` inside the `assets` directory
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
