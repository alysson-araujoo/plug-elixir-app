defmodule MyPlugApp.Router do
  use Plug.Router

  # Pipeline de Plugs padrão do Router
  plug Plug.Logger
  plug :match
  plug Plug.Parsers, parsers: [:urlencoded, :json], pass: ["*/*"], json_decoder: Jason
  plug :dispatch

  # Rota pública
  get "/" do
    send_resp(conn, 200, "Bem-vindo ao servidor Elixir Plug!")
  end

  # Rota com o nosso Plug customizado
  get "/protected" do
    conn = MyPlugApp.Plugs.VerifyHeader.call(conn, [])

    if conn.halted do
      conn
    else
      send_resp(conn, 200, "Acesso concedido à área protegida!")
    end
  end

  # Rota JSON para demonstração
  get "/api/status" do
    payload = Jason.encode!(%{status: "ok", uptime: "online"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, payload)
  end

  # Rota de Fallback (404)
  match _ do
    send_resp(conn, 404, "Página não encontrada")
  end
end
