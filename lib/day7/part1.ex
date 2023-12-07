defmodule Day7.Part1 do
  def solver(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn row ->
      [hand, bet] =
        row
        |> String.split()

      [hand, String.to_integer(bet)]
    end)
    |> Enum.sort(fn [curr_h | _], [next_h | _] ->
      !Day7.Hand.sorter(curr_h, next_h)
    end)
    |> Enum.with_index()
    |> Enum.reduce(0, fn {[_, bet], idx}, acc ->
      bet * (idx + 1) + acc
    end)
  end
end
