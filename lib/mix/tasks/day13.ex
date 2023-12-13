defmodule Mix.Tasks.Day13 do
  use Mix.Task

  @impl true
  def run(_args) do
    Utils.get_solution("./data/day13.txt", &Day13.Part1.solver/1)
    Utils.get_solution("./data/day13.txt", &Day13.Part2.solver/1)
  end
  
end
