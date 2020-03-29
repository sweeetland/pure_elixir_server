defmodule HttpServer do
  @port 8000
  @http_options [active: false, packet: :http_bin, reuseaddr: true]

  def init() do
    {:ok, socket} = :gen_tcp.listen(@port, @http_options)
    accept(socket)
  end

  def accept(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    pid = spawn(HttpServer, :handle, [client])
    :ok = :gen_tcp.controlling_process(client, pid)
    accept(socket)
  end
end
