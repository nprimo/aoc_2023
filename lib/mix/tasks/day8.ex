defmodule Mix.Tasks.Day8 do
  use Mix.Task

  @impl true
  def run(_args) do
    Utils.get_solution("./data/day8.txt", &Day8.Part1.solver/1)
  end
end
