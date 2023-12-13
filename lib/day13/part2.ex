defmodule Day13.Part2 do
  def solver(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(&get_one_smudge_reflection/1)
    |> Enum.reduce(0, fn {col_count, row_count}, acc ->
      case {col_count, row_count} do
        {count, nil} -> count + 1 + acc
        {_, count} -> 100 * (count + 1) + acc
      end
    end)
  end

  def get_one_smudge_reflection(map) do
    {get_one_smudge_v_reflection(map), get_one_smudge_h_reflection(map)}
  end

  def get_one_smudge_v_reflection(map) do
    rows =
      map
      |> String.split("\n", trim: true)

    row_len =
      rows |> Enum.at(0) |> String.length()

    1..(row_len - 1)
    |> Enum.map(fn col_n ->
      Enum.reduce(rows, 0, fn row, acc -> count_diff(row, col_n) + acc end)
    end)
    |> Enum.with_index()
    |> Enum.filter(fn {val, _pos} -> val == 1 end)
    |> Enum.map(fn {_, pos} -> pos end)
    |> Enum.at(0)
  end

  def get_one_smudge_h_reflection(map) do
    map
    |> Day13.Part1.transpose_map()
    |> get_one_smudge_v_reflection()
  end

  def count_diff(row, col_n) do
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

    ((1 - String.bag_distance(s1, s2)) * min_len)
    |> round()
  end
end
