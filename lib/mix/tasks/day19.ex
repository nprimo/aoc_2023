defmodule Mix.Tasks.Day19 do
  use Mix.Task

  @impl true
  def run(_) do
    Utils.get_solution("./data/day19.txt", &Day19.Part1.solver/1)
  end
  
end
