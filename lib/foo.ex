defmodule Foo do
  def exec() do
    Process.sleep(3_000)
    send(Fpanel.pid, {:event, %{ch: "t"}})
  end
end
