defmodule Mix.Tasks.Day23 do
  use Mix.Task

  @impl true
  def run(_) do
    #Utils.get_solution("./data/day23.txt", &Day23.Part1.solver/1)
    Utils.get_solution("./data/day23.txt", &Day23.Part2.solver/1, 2)
  end
end
