defmodule Mix.Tasks.Day1 do
  use Mix.Task

  # TODO: create an utils to perfrom this operation
  @impl Mix.Task
  def run(_args) do
    fname = "./data/day1.txt"

    solution_1 =
      File.read!(fname)
      |> Day1.decrypt_calibration_1()

    solution_2 =
      File.read!(fname)
      |> Day1.decrypt_calibration_2()

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

    IO.puts(
      [
        "Solution part 2:\n",
        :green,
        "#{solution_2}",
        :reset
      ]
      |> IO.ANSI.format()
      |> IO.chardata_to_string()
    )
  end
end
