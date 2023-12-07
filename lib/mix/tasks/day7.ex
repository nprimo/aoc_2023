defmodule Mix.Tasks.Day7 do
  use Mix.Task

  @impl(true)
  def run(_args) do
    Utils.get_solution("./data/day7.txt", &Day7.Part1.solver/1)
  end
  
end
