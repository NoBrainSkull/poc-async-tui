defmodule TUI.Events do
  import TUI.Actions
  import TUI.Actions.{AWS, FakeErrors}

  # Starting the awaiting-for-events loop
  def start_link, do: {:ok, spawn_link(&loop/0)}

  defp loop do
    receive do
      x -> handle_event(x)
      loop()
    end
  end

  # On "q" keypress, exit
  def handle_event({:event, %{ch: ?q}}), do: TUI.stop()
  # On "a" keypress, list aws apikeys ids
  def handle_event({:event, %{ch: ?a}}), do: exec(&list_last_posts/1)
  # On "e" keypress, raise a fake error
  def handle_event({:event, %{ch: ?e}}), do: exec(&just_a_fake_error/1)
  # Otherwise ignore
  def handle_event(_), do: :ignore
end
