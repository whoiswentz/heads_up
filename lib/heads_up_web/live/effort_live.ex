defmodule HeadsUpWeb.EffortLive do
  use HeadsUpWeb, :live_view

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Process.send_after(self(), :tick, 2000)
    end

    socket =
      socket
      |> assign(responders: 0)
      |> assign(minutes_per_responder: 10)

    {:ok, socket}
  end

  def handle_event("add", %{"quantity" => quantity}, socket) do
    socket = update(socket, :responders, &(&1 + String.to_integer(quantity)))

    {:noreply, socket}
  end

  def handle_event("recalculate", %{"minutes" => minutes}, socket) do
    socket = assign(socket, :minutes_per_responder, String.to_integer(minutes))

    {:noreply, socket}
  end

  def handle_info(:tick, socket) do
    Process.send_after(self(), :tick, 2000)
    socket = update(socket, :responders, &(&1 + 10))
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="effort">
      <h1>Community Love</h1>
      <section>
        <button phx-click="add" phx-value-quantity="3">
          + 3
        </button>
        <div>
          <%= @responders %>
        </div>
        &times;
        <div>
          <%= @minutes_per_responder %>
        </div>
        =
        <div>
          <%= @minutes_per_responder * @responders %>
        </div>
      </section>
      <form phx-submit="recalculate">
        <label for="minutes">Minutes Per Responder: </label>
        <input type="number" name="minutes" value={@minutes_per_responder} />
      </form>
    </div>
    """
  end
end
