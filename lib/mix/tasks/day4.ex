defmodule Mix.Tasks.Day4 do
  use Mix.Task

  @impl true
  def run(_args) do
    fname = "./data/day4.txt"

    Utils.get_solution(fname, &Day4.solver1/1)
  end
  
end
