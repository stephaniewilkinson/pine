defmodule PineWeb.WishLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <div>
      <form phx-submit="submit-link">
        <input name="location" placeholder="Location" value="<%= @location %>"/>
        <%= @weather %>
      </form>
    </div>
    """
  end

  def mount(_session, socket) do
    send(self(), {:put, "http"})
    {:ok, assign(socket, location: nil, weather: "...")}
  end

  def handle_event("submit-link", %{"location" => location}, socket) do
    {:noreply, put_location(socket, location)}
  end

  def handle_info({:put, location}, socket) do
    {:noreply, put_location(socket, location)}
  end

  defp put_location(socket, location) do
    assign(socket, location: location, weather: weather(location))
  end

  defp weather(local) do
    {:ok, {{_, 200, _}, _, body}} =
      :httpc.request(:get, {~c"http://wttr.in/#{local}?format=1", []}, [], [])
    IO.iodata_to_binary(body)
  end
end
