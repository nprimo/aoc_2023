defmodule Day13.Part1 do
  def solver(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(&get_reflections/1)
    |> Enum.reduce(0, fn {col_count, row_count}, acc ->
      case {col_count, row_count} do
        {nil, count} -> 100 * count + acc
        {count, nil} -> count + acc
      end
    end)
  end

  def get_reflections(map) do
    {get_vertical_reflection(map), get_horizontal_reflection(map)}
  end

  def get_vertical_reflection(map) do
    rows =
      map
      |> String.split("\n", trim: true)

    row_len =
      rows |> Enum.at(0) |> String.length()

    1..(row_len - 1)
    |> Enum.reduce_while([], fn col_n, acc ->
      if Enum.all?(rows, &is_vertical_reflection?(&1, col_n)) do
        {:halt, acc ++ [col_n]}
      else
        {:cont, acc}
      end
    end)
    |> Enum.at(0)
  end

  def get_horizontal_reflection(map) do
    map
    |> transpose_map()
    |> get_vertical_reflection()
  end

  def transpose_map(map) do
    map
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.join/1)
    |> Enum.join("\n")
  end

  def is_vertical_reflection?(row, col_n) do
    {first_half, second_half} = String.split_at(row, col_n)

    first_half =
      first_half |> String.reverse()

    min_len =
      min(
        String.length(first_half),
        String.length(second_half)
      )

    s1 = String.slice(first_half, 0..(min_len - 1))
    s2 = String.slice(second_half, 0..(min_len - 1))

    s1 == s2
  end
end
