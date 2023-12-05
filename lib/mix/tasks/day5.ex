defmodule Mix.Tasks.Day5 do
  use Mix.Task

  @impl true
  def run(_args) do
    Utils.get_solution("./data/day5.txt", &Day5.solver1/1)
  end
  
end
