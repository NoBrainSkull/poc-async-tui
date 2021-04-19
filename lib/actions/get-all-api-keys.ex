defmodule TUI.Actions.AWS do
  @moduledoc """
  Actions module hold all the code which is meant to be executed as an async task for this poc. See actions.ex
  file to understand how they are expected to be called.
  """

  @success_exit_code 0

  @doc """
  List all aws apigateway keys ids to be displayed in the window
  """
  def list_all_api_keys(current_state) do
    keys = with { json_result, @success_exit_code } <- System.cmd("aws", ~w(--profile orkestra --region eu-west-1 apigateway get-api-keys)),
          %{ "items" => keys } <- Poison.decode!(json_result),
    do: keys

    Enum.map(keys, & &1["id"])
      |> (fn ids -> Map.put(current_state, :content, "Your keys are \n#{Enum.join(ids, "\n")}") end).()
  end
end
