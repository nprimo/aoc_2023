defmodule Utils do
  def get_solution(fname, fun, part_n \\ 1) do
    solution =
      File.read!(fname)
      |> fun.()

    IO.puts(
      [
        "Solution part #{part_n}:\n",
        :green,
        "#{solution}",
        :reset
      ]
      |> IO.ANSI.format()
      |> IO.chardata_to_string()
    )
  end
end
