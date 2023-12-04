defmodule Mix.Tasks.Day3 do
  use Mix.Task

  @impl true
  def run(_args) do
    Utils.get_solution("./data/day3.txt", &Day3.solver1/1)
  end
end
