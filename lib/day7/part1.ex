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
    |> Enum.map(fn [h, b] -> [h, b, Day7.Hand.get_score(h)] end)
    |> Enum.map(fn [h, b, score] ->
      %{bet: b, score: score * 10 ** 7 + Day7.Hand.to_num(h)}
    end)
    |> Enum.sort_by(& &1.score)
    |> Enum.with_index()
    |> Enum.reduce(0, fn {%{bet: bet, score: _}, idx}, acc ->
      bet * (idx + 1) + acc
    end)
  end
end
