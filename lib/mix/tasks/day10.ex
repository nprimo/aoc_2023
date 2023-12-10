defmodule Mix.Tasks.Day10 do
  use Mix.Task

  @impl true
  def run(_args) do
  Utils.get_solution("./data/day10.txt", &Day10.Part1.solver/1)
  end
  
end
