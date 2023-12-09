defmodule Day9.Part2 do
  def solver(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split()
      |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.map(&get_history/1)
    |> Enum.map(&get_first_value/1)
    |> Enum.reduce(0, fn x, acc -> x + acc end)
  end

  def get_first_value(history) do
    history
    |> Enum.map(&List.first/1)
    |> Enum.reverse()
    |> Enum.slice(1..-1)
    |> Enum.reduce(0, fn x, acc -> x - acc end)
  end

  def get_history(line, diff \\ []) do
    diff =
      diff ++ [line]

    curr_diff =
      line
      |> get_difference()

    if Enum.all?(curr_diff, &(&1 == 0)) do
      diff ++ [curr_diff]
    else
      get_history(curr_diff, diff)
    end
  end

  def get_difference(line) do
    [line, Enum.slice(line, 1..-1)]
    |> Enum.zip()
    |> Enum.map(&(elem(&1, 1) - elem(&1, 0)))
  end
end
