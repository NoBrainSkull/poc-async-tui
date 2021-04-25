defmodule TUI.Actions.AWS do
  @moduledoc """
  Actions module hold all the code which is meant to be executed as an async task for this poc. See actions.ex
  file to understand how they are expected to be called.
  """

  @doc """
  List the 10 last posts in /r/elixir
  """
  def list_last_posts(current_state) do
    with %{body: body_string } <- HTTPoison.get!("https://www.reddit.com/r/elixir/new/.json?count=10"),
        body_json <- Poison.decode!(body_string),
        posts_titles_list <- get_in(body_json, ["data", "children"]) |> Enum.map(& get_in(&1, ["data", "title"])),
        window_content <- "/r/elixir 10 most recent posts are : \n\n#{Enum.join(posts_titles_list, "\n")}",
    do: Map.put(current_state, :content, window_content)
  end
end
