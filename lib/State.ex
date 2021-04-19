defmodule State do
  use Agent

  def init(initial_state \\%{}) do
    Agent.start_link(fn -> initial_state end, name: __MODULE__)
  end

  def put(key, value) do
    Agent.update(__MODULE__, &(Map.put(&1, key, value)))
    Agent.get(__MODULE__, &(Map.get(&1, key)))
  end

  def get(key) do
    Agent.get(__MODULE__, &(Map.get(&1, key)))
  end
end
