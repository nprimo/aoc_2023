defmodule Mix.Tasks.Day23 do
  use Mix.Task

  @impl true
  def run(_) do
    Utils.get_solution("./data/day23.txt", &Day23.Part1.solver/1)
  end
end
