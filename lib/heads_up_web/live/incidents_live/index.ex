defmodule HeadsUpWeb.IncidentsLive.Index do
  use HeadsUpWeb, :live_view

  alias HeadsUp.{Incidents, Incident}

  import HeadsUpWeb.CustomComponents.BadgeComponents

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
end
