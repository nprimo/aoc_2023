defmodule Day7.Hand do
  # Most valuable card to the beginning of the list
  @cards "AKQJT98765432"
  @type_points %{
    five: 6,
    poker: 5,
    tris: 3,
    pair: 1
  }

  def to_num(hand, num \\ 0)
  def to_num("", num), do: num

  def to_num(<<card, rest::bits>>, num) do
    curr_pos =
      @cards
      |> String.reverse()
      |> String.to_charlist()
      |> Enum.find_index(&(&1 == card))

    new_num = num * String.length(@cards) + curr_pos

    to_num(rest, new_num)
  end

  def get_types(hand) do
    hand
    |> String.graphemes()
    |> Enum.frequencies()
    |> Map.to_list()
    |> Enum.map(fn
      {card, freq} ->
        {card,
         case freq do
           5 -> :five
           4 -> :poker
           3 -> :tris
           2 -> :pair
           _ -> nil
         end}
    end)
  end

  def get_score(hand) do
    hand
    |> get_types()
    |> Enum.reduce(0, fn {_, type}, acc ->
      case Map.get(@type_points, type) do
        nil -> acc
        num -> num + acc
      end
    end)
  end

  def sorter(curr, other) do
    [curr_score, other_score] =
      [curr, other]
      |> Enum.map(&get_score/1)

    [curr_num, other_num] =
      [curr, other]
      |> Enum.map(&to_num/1)

    if curr_score == other_score do
      curr_num >= other_num
    else
      curr_score > other_score
    end
  end
end
