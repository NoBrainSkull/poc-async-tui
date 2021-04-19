defmodule TUI do
  use Application
  alias Ratatouille.{EventManager, Window}
  alias TUI.{Events, State}

  import Ratatouille.View

  @initial_state %{
    title: "Hello, World!",
    content: "So, this is the default content."
  }

  def start(_type, _args) do
    {:ok, _pid} = State.start_link()
    {:ok, _pid} = Window.start_link()
    {:ok, _pid} = EventManager.start_link() # Ratatouille called it "Manager" but it's more like a Pub Server really
    {:ok, event_sub} = Events.start_link()  # So this is the actual Manager, an event subscriber
    :ok = EventManager.subscribe(event_sub) # Subscribing the client to the server
    State.reset(@initial_state)
    {:ok, self()}
  end

  def stop() do
    Window.close()
    Process.exit(self(), :exit_success) # should be replaced with the pid of the app.
  end

  # To keep things simple, rendering occurs when state is updated
  # First state update occurs on start (see above)
  def render() do
    Window.update(view do
      row do
        column(size: 8) do
          panel title: "#{State.get(:title)}", height: :fill do
            label(content: "#{State.get(:content)}")
          end
        end
        column(size: 4) do
          panel title: "Error panel", height: :fill, background: :blue do
            label(content: "#{State.get(:error)}")
          end
        end
      end
    end)
  end
end
