defmodule Mix.Tasks.Day14 do
  use Mix.Task

  @impl true
  def run(_) do
    Utils.get_solution("./data/day14.txt", &Day14.Part1.solver/1)
  end
end
