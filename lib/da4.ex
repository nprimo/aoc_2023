defmodule Day4 do
  def solver1(input) do
    input
    |> String.trim_trailing()
    |> String.split("\n")
    |> Enum.map(fn line -> parse_line(line) end)
    |> Enum.reduce(0, fn x, acc -> x + acc end)
  end

  def parse_line(line) do
    [winning_num, played_num] =
      line
      |> String.split(": ")
      |> Enum.at(1)
      |> String.split("| ")
      |> Enum.map(fn nums ->
        nums
        |> String.split(" ", trim: true)
      end)

    matches =
      played_num
      |> Enum.filter(fn num ->
        if(
          winning_num
          |> Enum.filter(&(&1 == num))
          |> length() == 1
        ) do
          true
        else
          false
        end
      end)
      |> length()

    if matches == 0 do
      0
    else
      :math.pow(2, matches - 1)
      |> trunc
    end
  end
end
