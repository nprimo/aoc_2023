defmodule Day15.Part1 do
  def solver(input) do
    input
    |> String.trim_trailing()
    |> String.split(",")
    |> Enum.map(&hash_algo/1)
    |> Enum.reduce(0, fn x, acc -> x + acc end)
  end

  def hash_algo(word) do
    word
    |> String.to_charlist()
    |> Enum.reduce(0, fn c, acc ->
      val =
        (c + acc) * 17

      rem(val, 256)
    end)
  end
end
