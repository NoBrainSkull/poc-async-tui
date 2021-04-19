defmodule TUI.State do
  use Agent
  @moduledoc """
  This module describe the data that will be use for rendering. In a real-life application
  this would need to be more complex to control how the state can be changed. In this Poc
  we are keeping it simple as it is about Processes.
  Though if you find fonctionnal-programming state control, here is a great reading (though a long one) :
                              https://day8.github.io/re-frame/a-loop/
  """

  # By starting the agent with name option
  # I force to have only one process to represent
  # TUI State because having several wouldn't make sense.
  @spec start_link(any) :: {:error, any} | {:ok, pid}
  def start_link(initial_state \\%{}), do:
    Agent.start_link(fn -> initial_state end, name: __MODULE__)

  # Update the whole TUI State and ask TUI (parent) to rerender
  def reset(new_state) do
    Agent.update(__MODULE__, fn (_prev_state) -> new_state end)
    TUI.render()
  end

  # Update one value of TUI State and ask TUI (parent) to rerender
  def put(key, value) do
    Agent.update(__MODULE__, &(Map.put(&1, key, value)))
    Agent.get(__MODULE__, &(Map.get(&1, key)))
    TUI.render()
  end

  @doc "Read all the state"
  def get, do: Agent.get(__MODULE__, & &1)

  @doc "Read a specific key stored in state"
  def get(key) do
    Agent.get(__MODULE__, &(Map.get(&1, key)))
  end
end
