defmodule HeadsUpWeb.IncidentsLive.Index do
  use HeadsUpWeb, :live_view

  alias HeadsUp.{Incidents, Incident}

  def mount(_params, _session, socket) do
    socket = assign(socket, :incidents, Incidents.list_incidents())
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="incident-index">
      <div class="incidents">
        <.incident_card :for={incident <- @incidents} incident={incident} />
      </div>
    </div>
    """
  end

  attr :incident, Incident, required: true

  def incident_card(assigns) do
    ~H"""
    <div class="card">
      <img src={@incident.image_path} alt={@incident.description} />
      <h2><%= @incident.name %></h2>
      <div class="details">
        <.status_badge status={@incident.status} />
        <.priority_badge priority={@incident.priority} />
      </div>
    </div>
    """
  end

  attr :status, :atom, values: [:pending, :resolved, :canceled], default: :pending

  def status_badge(assigns) do
    ~H"""
    <div class="rounded-md px-2 py-1 text-xs font-medium uppercase inline-block border text-lime-600 border-lime-600">
      <%= @status %>
    </div>
    """
  end

  attr :priority, :atom, values: [:pending, :resolved, :canceled], default: :pending

  def priority_badge(assigns) do
    ~H"""
    <div class="text-xs text-white font-medium bg-gray-500 rounded-full px-3 py-1.5">
      <%= @priority %>
    </div>
    """
  end
end
