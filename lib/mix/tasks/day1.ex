defmodule Mix.Tasks.Day1 do
  use Mix.Task

  @impl Mix.Task
  def run(_args) do
    fname = "./data/day1.txt"

    Utils.get_solution(fname, &Day1.decrypt_calibration_1/1)
    Utils.get_solution(fname, &Day1.decrypt_calibration_2/1)

  end
end
