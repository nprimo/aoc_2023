defmodule Mix.Tasks.Day24 do
  use Mix.Task

  @impl true
  def run(_) do
    Utils.get_solution("./data/day24.txt", &Day24.Part1.solver/1)
  end
  
end
