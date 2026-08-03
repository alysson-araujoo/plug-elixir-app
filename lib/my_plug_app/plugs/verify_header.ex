defmodule MyPlugApp.Plugs.VerifyHeader do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_req_header(conn, "x-app-key") do
      ["secret123"] ->
        conn

      _ ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(401, Jason.encode!(%{error: "Acesso não autorizado!"}))
        |> halt()
    end
  end
end
