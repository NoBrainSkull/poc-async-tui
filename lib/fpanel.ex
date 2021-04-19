defmodule Fpanel do
  alias Ratatouille.{EventManager, Window}

  import Ratatouille.View

  def init do
    State.init
    {:ok, _pid} = Window.start_link()
    {:ok, pid} = EventManager.start_link()
    :ok = EventManager.subscribe(self())
    loop()
  end

  def pid, do: self()
  
  def render(content) do
    view do
      panel title: "Hello, World!", height: :fill do
        label(content: "#{content}")
      end
    end
  end

  def loop({:kill, true}), do: Window.close()
  def loop({:exec, _process}), do: loop()
  def loop({:bad_input, true}) do
    State.put(:content, "This is the help message")
    loop()
  end
  def loop do
    Window.update(render(State.get(:content)))
    receive do
      x -> loop(handle_event(x))
    end
  end

  def handle_event({:event, %{ch: ?q}}), do: {:kill, true}
  def handle_event({:event, %{ch: ?u}}), do: {:exec, Foo.exec()}
  def handle_event(_), do: {:bad_input, true}
end