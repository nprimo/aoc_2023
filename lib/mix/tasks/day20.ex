defmodule Mix.Tasks.Day20 do
  use Mix.Task

  @impl true
  def run(_) do
    Utils.get_solution("./data/day20.txt", &Day20.Part1.solver/1)
  end
  
end
