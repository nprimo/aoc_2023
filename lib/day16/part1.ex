defmodule Day16.Part1 do
  def solver(input) do
    map =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.graphemes/1)

    multiple_walks([[{0, 0}, {1, 0}]], map)
    |> Enum.map(fn [pos, _] -> pos end)
    |> Enum.uniq()
    |> length()
  end

  def multiple_walks(start_list, map, collective_path \\ [])
  def multiple_walks([], _, collective_path), do: collective_path

  def multiple_walks(start_list, map, collective_path) do
    res =
      start_list
      |> Enum.uniq()
      |> Enum.map(fn [curr, dir] ->
        walk(curr, dir, map)
      end)
      |> Enum.map(fn [path, start_list] ->
        %{path: path, start_list: start_list}
      end)
      |> Enum.reduce(%{path: [], start_list: []}, fn val, acc ->
        acc =
          acc
          |> Map.update!(:path, fn curr -> curr ++ val.path end)

        acc
        |> Map.update!(:start_list, fn curr -> curr ++ val.start_list end)
      end)

    new_collective_path =
      (collective_path ++ res.path)
      |> Enum.uniq()

    new_start_list =
      res.start_list
      |> Enum.filter(fn [pos, dir] ->
        !Enum.any?(new_collective_path, fn [seen_pos, seen_dir] ->
          seen_pos == pos and seen_dir == dir
        end)
      end)

    multiple_walks(new_start_list, map, new_collective_path)
  end

  def walk(curr, dir, map, path \\ [], new_start \\ [])

  def walk(curr, dir, map, path, new_start) do
    new_path =
      path ++ [[curr, dir]]

    next_step = {
      elem(curr, 0) + elem(dir, 0),
      elem(curr, 1) + elem(dir, 1)
    }

    if !is_in_map?(next_step, map) do
      [new_path, new_start]
    else
      [new_dir, start] = update_dir(next_step, dir, map)

      new_start =
        if start != nil do
          new_start ++ [start]
        else
          new_start
        end

      walk(next_step, new_dir, map, new_path, new_start)
    end
  end

  def update_dir(curr, dir, map) do
    map_at_curr =
      map
      |> Enum.at(elem(curr, 1))
      |> Enum.at(elem(curr, 0))

    case [map_at_curr, dir] do
      ["\\", {val, 0}] -> [{0, val}, nil]
      ["\\", {0, val}] -> [{val, 0}, nil]
      ["/", {val, 0}] -> [{0, -val}, nil]
      ["/", {0, val}] -> [{-val, 0}, nil]
      ["|", {_, 0}] -> [{0, -1}, [curr, {0, 1}]]
      ["-", {0, _}] -> [{-1, 0}, [curr, {1, 0}]]
      _ -> [dir, nil]
    end
  end

  def is_in_map?(pos, map) do
    y_max = length(map)
    x_max = Enum.at(map, 0) |> length()

    elem(pos, 0) < x_max and elem(pos, 1) < y_max and
      (elem(pos, 0) >= 0 and elem(pos, 1) >= 0)
  end
end
