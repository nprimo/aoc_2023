defmodule Day23.Part1 do
  @direction [
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

    start_pos_x =
      map
      |> Enum.at(0)
      |> Enum.find_index(&(&1 == "."))

    start_pos = {start_pos_x, 0}

    end_pos_x =
      map
      |> Enum.at(-1)
      |> Enum.find_index(&(&1 == "."))

    end_pos = {end_pos_x, length(map) - 1}

    walk(start_pos, end_pos, map)
    |> dbg(charlists: :to_lists)
  end

  def walk(pos, end_pos, map, path \\ [])

  def walk(pos, end_pos, map, path) do
    # update paht with current position (assume position is always good)

    # case 1 -> pos == end_position -> return path

    # case 2 -> move 
    # - calculate next positions:
    #   * it must be inside the map
    #   * it must not be in the previous path
    #   * if it's an arrow -> make it only the specific one
    # - for each new position call funciton
  end

  def get_next_pos(pos, tile, map, path) do
    case tile do
      ">" ->
        [{elem(pos, 0) + 1, elem(pos, 1) + 0}]

      "<" ->
        [{elem(pos, 0) + -1, elem(pos, 1) + 0}]

      "^" ->
        [{elem(pos, 0) + 0, elem(pos, 1) + -1}]

      "v" ->
        [{elem(pos, 0) + 0, elem(pos, 1) + 1}]

      nil ->
        []

      _ ->
        @direction
        |> Enum.map(fn {dir_x, dir_y} ->
          {
            elem(pos, 0) + dir_x,
            elem(pos, 1) + dir_y
          }
        end)
    end
    |> Enum.filter(&is_in_map?(&1, map))
    |> Enum.filter(fn pos -> !Enum.any?(path, &(&1 == pos)) end)
  end

  def is_in_map?({x, y}, map) do
    x_max = map |> Enum.at(0) |> length
    y_max = map |> length

    x >= 0 and x < x_max and (y >= 0 and y < y_max)
  end

  def get_map_pos({x, y}, map) do
    if is_in_map?({x, y}, map) do
      map
      |> Enum.at(y)
      |> Enum.at(x)
    else
      nil
    end
  end
end
