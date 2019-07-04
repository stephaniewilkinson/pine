defmodule PineWeb.PageController do
  use PineWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
