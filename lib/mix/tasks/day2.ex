defmodule Mix.Tasks.Day2 do
  use Mix.Task

  @impl Mix.Task
  def run(_args) do
    fname = "./data/day2.txt"

    solution_1 =
      File.read!(fname)
      |> Day2.solver()

    IO.puts(
      [
        "Solution part 1:\n",
        :green,
        "#{solution_1}",
        :reset
      ]
      |> IO.ANSI.format()
      |> IO.chardata_to_string()
    )
  end
end
