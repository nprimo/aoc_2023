defmodule Mix.Tasks.Day11 do
  use Mix.Task

  @impl true
  def run(_args) do
    Utils.get_solution("./data/day11.txt", &Day11.Part1.solver/1)
    Utils.get_solution("./data/day11.txt", &Day11.Part2.solver/1)
  end
end
