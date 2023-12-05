defmodule Mix.Tasks.Day5 do
  use Mix.Task

  @impl true
  def run(_args) do
    Utils.get_solution("./data/day5.txt", &Day5.Part1.solver/1)
    #Utils.get_solution("./data/day5.txt", &Day5.solver2/1)
  end
end
