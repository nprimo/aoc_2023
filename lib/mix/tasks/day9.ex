defmodule Mix.Tasks.Day9 do
  use Mix.Task

  @impl true
  def run(_args) do
    Utils.get_solution("./data/day9.txt", &Day9.Part1.solver/1)
    Utils.get_solution("./data/day9.txt", &Day9.Part2.solver/1, 2)
  end
end

