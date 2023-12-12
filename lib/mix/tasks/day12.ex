defmodule Mix.Tasks.Day12 do
  use Mix.Task

  @impl true
  def run(_args) do
    Utils.get_solution("./data/day12.txt", &Day12.Part1.solver/1)
  end
  
end
