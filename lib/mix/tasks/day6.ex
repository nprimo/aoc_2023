defmodule Mix.Tasks.Day6 do
  use Mix.Task

  @impl true
  def run(_args) do
    Utils.get_solution("./data/day6.txt", &Day6.Part1.solver/1)
  end  
end
