defmodule Day7.Hand do
  @cards "AKQJT98765432"
  @type_points %{
    five: 6,
    poker: 5,
    tris: 3,
    pair: 1
  }

  def to_num(hand, num \\ 0)
  def to_num("", num), do: num

  def to_num(<<card, rest::binary>>, num) do
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
end
