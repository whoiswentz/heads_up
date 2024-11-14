defmodule HeadsUpWeb.CustomComponents.BadgeComponents do
  use HeadsUpWeb, :html

  attr :status, :atom, values: [:pending, :resolved, :canceled], default: :pending
  attr :class, :string, default: nil
  attr :rest, :global

  def status_badge(assigns) do
    ~H"""
    <div
      class={[
        "rounded-md px-2 py-1 text-xs font-medium uppercase inline-block border",
        @status == :resolved && "text-lime-600 border-lime-600",
        @status == :pending && "text-amber-600 border-amber-600",
        @status == :canceled && "text-gray-600 border-gray-600",
        @class
      ]}
      {@rest}
    >
      <%= @status %>
    </div>
    """
  end

  attr :priority, :atom, values: [:pending, :resolved, :canceled], default: :pending
  attr :class, :string, default: nil
  attr :rest, :global

  def priority_badge(assigns) do
    ~H"""
    <div
      class={[
        "text-xs text-white font-medium bg-gray-500 rounded-full px-3 py-1.5",
        @class
      ]}
      {@rest}
    >
      <%= @priority %>
    </div>
    """
  end
end
