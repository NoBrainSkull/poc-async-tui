defmodule TUI.Actions do
  @moduledoc """
  A TUI.Action trigger an Task to perform an async job. It only make sense that this
  action will result in a state change (effects), otherwise it would be useless. So
  as an Action to work with all it need, its first argument is the current state (coeffects)
  and its result will be the desired resulting state (data). The state is effectively changed
  in this module in a very controlled way, not randomly in each actions.
  """

  def exec(fun) do
    Task.async(fn ->
      try do
        current_state = TUI.State.get() # In Fonctionnal Programming, this is called "coeffects"
        desired_state = fun.(current_state) # Business functions describe how they would like the state to be without changing it

        # Applying effects. Because applying effects is a dangerous operation for app consistency,
        # doing it once in the lifecycle at one specific place allow us to perform effecient
        # error recover and consistency checks (which I won't be doing for this PoC).
        # But note it's still done by the Tasks
        TUI.State.reset(desired_state)


      # I offer here a very poor error handling. Thanks to the design I made, a Task should be supervised instead of trying to
      # compensate for its errors. But I don't know yet how to properly use supervision.
      rescue
        _ -> TUI.State.put(:error, "An error occured while performing an action.")
      end
    end)
  end
end
