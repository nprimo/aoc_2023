defmodule Day21.Part1 do
  @directions [
    {0, 1},
    {0, -1},
    {1, 0},
    {-1, 0}
  ]

  def solver(input) do
    map =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.graphemes/1)

    start_pos =
      map
      |> Enum.with_index()
      |> Enum.filter(fn {row, _} -> Enum.any?(row, &(&1 == "S")) end)
      |> Enum.map(fn {row, row_n} ->
        {
          Enum.find_index(row, fn char -> char == "S" end),
          row_n
        }
      end)
      |> List.first()

    possible_steps([start_pos], map)
    |> length()
  end

  def possible_steps(curr_pos, map, steps \\ 64)

  def possible_steps(curr_pos, _, 0), do: curr_pos

  def possible_steps(curr_pos, map, steps) do
    possible_new_pos =
      curr_pos
      |> Enum.map(fn pos ->
        @directions
        |> Enum.map(fn dir ->
          {
            elem(pos, 0) + elem(dir, 0),
            elem(pos, 1) + elem(dir, 1)
          }
        end)
      end)
      |> List.flatten()

    new_pos =
      possible_new_pos
      |> Enum.uniq()
      |> Enum.filter(&(check_map(&1, map) != "#"))

    possible_steps(new_pos, map, steps - 1)
  end

  def check_map(pos, map) do
    map
    |> Enum.at(elem(pos, 1))
    |> Enum.at(elem(pos, 0))
  end
end
