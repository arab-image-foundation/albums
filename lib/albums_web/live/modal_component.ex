defmodule AlbumsWeb.ModalComponent do
  use AlbumsWeb, :live_component

  @impl true
  def render(assigns) do
    ~L"""
    <div id="<%= @id %>" class="live-modal fade" tabindex="-1"
      phx-capture-click="close"
      phx-window-keydown="close"
      phx-key="escape"
      phx-target="#<%= @myself %>"
      phx-page-loading>

      <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
          <%= live_patch "", to: @return_to, class: "btn-close",  aria_label: "Close" %>
          <div class="modal-body">
            <%= live_component @socket, @component, @opts %>
          </div>
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("close", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end
end
