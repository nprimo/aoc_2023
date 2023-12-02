defmodule Utils do
  def get_solution(fname, fun) do
    solution =
      File.read!(fname)
      |> fun.()

    IO.puts(
      [
        "Solution part 1:\n",
        :green,
        "#{solution}",
        :reset
      ]
      |> IO.ANSI.format()
      |> IO.chardata_to_string()
    )
  end
end
