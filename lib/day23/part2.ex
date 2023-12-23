defmodule Day23.Part2 do
  import Day23.Part1, except: [walk: 3, walk: 4]

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

    res =
      walk(start_pos, end_pos, map)
      |> List.flatten()

    {len, path} =
      res
      |> Enum.max_by(&elem(&1, 0))

    len - 1
  end

  def walk(pos, end_pos, map, path \\ [])

  def walk(nil, _, _, _), do: nil

  def walk(pos, end_pos, map, path) do
    path = path ++ [pos]

    if pos == end_pos do
      {length(path), path}
    else
      next_pos = move(pos, map, path)
      for pos <- next_pos, do: walk(pos, end_pos, map, path)
    end
  end

  def move(pos,map, path) do
    @direction
    |> Enum.map(fn {dir_x, dir_y} ->
      {
        elem(pos, 0) + dir_x,
        elem(pos, 1) + dir_y
      }
    end)
    |> Enum.filter(&is_in_map?(&1, map))
    |> Enum.filter(&(get_map_pos(&1, map) != "#"))
    |> Enum.filter(fn pos -> !Enum.any?(path, &(&1 == pos)) end)
  end
end
