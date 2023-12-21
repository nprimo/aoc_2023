defmodule Mix.Tasks.Day21 do
  use Mix.Task
  
  @impl true
  def run(_) do
    Utils.get_solution("./data/day21.txt", &Day21.Part1.solver/1)
  end
end
