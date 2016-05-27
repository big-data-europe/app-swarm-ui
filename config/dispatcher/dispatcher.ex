defmodule Dispatcher do
  use Plug.Router

  def start(_argv) do
    port = 80
    IO.puts "Starting Plug with Cowboy on port #{port}"
    Plug.Adapters.Cowboy.http __MODULE__, [], port: port
    :timer.sleep(:infinity)
  end

  plug Plug.Logger
  plug :match
  plug :dispatch

  # In order to forward the 'themes' resource to the
  # resource service, use the following forward rule.
  #
  # docker-compose stop; docker-compose rm; docker-compose up
  # after altering this file.
  #
  # match "/themes/*path" do
  #   Proxy.forward conn, path, "http://resource/themes/"
  # end

  match "/repositories/*path" do
    Proxy.forward conn, path, "http://resource/repositories/"
  end

  match "/pipeline-instances/*path" do
    Proxy.forward conn, path, "http://resource/pipeline-instances/"
  end

  match "/services/*path" do
    Proxy.forward conn, path, "http://resource/services/"
  end

  match "/statuses/*path" do
    Proxy.forward conn, path, "http://resource/statuses/"
  end

  match "/swarm/*path" do
    Proxy.forward conn, path, "http://swarm/"
  end

  match _ do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
