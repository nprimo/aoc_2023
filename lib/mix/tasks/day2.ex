defmodule Mix.Tasks.Day2 do
  use Mix.Task

  @impl Mix.Task
  def run(_args) do
    fname = "./data/day2.txt"

    Utils.get_solution(fname, &Day2.solver/1)
    Utils.get_solution(fname, &Day2.solver2/1)

  end
end
