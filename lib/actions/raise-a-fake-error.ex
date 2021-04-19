defmodule TUI.Actions.FakeErrors do
  def just_a_fake_error(_current_state) do
    raise "fake error"
  end
end
