defmodule Mix.Tasks.Day15 do
  use Mix.Task

  @impl true
  def run(_) do
    Utils.get_solution("./data/day15.txt", &Day15.Part1.solver/1)
    Utils.get_solution("./data/day15.txt", &Day15.Part2.solver/1)
  end
  
end
