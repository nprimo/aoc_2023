defmodule Mix.Tasks.Day16 do
  use Mix.Task

  @impl true
  def run(_) do
    Utils.get_solution("./data/day16.txt", &Day16.Part1.solver/1)
  end
  
end
