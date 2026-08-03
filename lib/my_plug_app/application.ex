defmodule MyPlugApp.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: MyPlugApp.Router, options: [port: 4000]}
    ]

    opts = [strategy: :one_for_one, name: MyPlugApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
