defmodule Day10.Part1 do
  @pipe_type %{
    "|" => {:north, :south},
    "-" => {:east, :west},
    "L" => {:north, :west},
    "J" => {:north, :east},
    "7" => {:south, :east},
    "F" => {:south, :west},
    "S" => 0
  }

  @directions %{
    :north => -1,
    :south => 1,
    :east => -10,
    :west => 10
  }

  def solver(input) do
    map =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, ""))
      |> Enum.map(fn row ->
        row
        |> Enum.map(fn char ->
          if Map.has_key?(@pipe_type, char) do
            @pipe_type
            |> Map.get(char)
          end
        end)
      end)

    start =
      get_start(map)

    next_step =
      start
      |> get_close_tiles(map)
      |> Enum.at(1)

    path_len =
      walk(Map.get(next_step, "pos"), Map.get(next_step, "pipe"), map, [start])
      |> length()

    div(path_len , 2)
  end

  def walk(pos, directions, map, path) do
    path =
      path ++ [pos]

    new_pos_opt =
      directions
      |> Tuple.to_list()
      |> Enum.map(&move(pos, &1))

    if Enum.all?(new_pos_opt, &Enum.any?(path, fn val -> val == &1 end)) do
      path
    else
      new_pos =
        new_pos_opt
        |> Enum.filter(&(!Enum.any?(path, fn val -> val == &1 end)))
        |> Enum.at(0)

      new_directions =
        map
        |> Enum.at(elem(new_pos, 1))
        |> Enum.at(elem(new_pos, 0))

      walk(new_pos, new_directions, map, path)
    end
  end

  def get_start(map) do
    map
    |> Enum.with_index()
    |> Enum.filter(fn {row, _} -> Enum.any?(row, &(&1 == 0)) end)
    |> Enum.map(fn {row, row_n} ->
      col_n =
        row
        |> Enum.find_index(&(&1 == 0))

      {col_n, row_n}
    end)
    |> Enum.at(0)
  end

  def move(pos, dir) when is_atom(dir) do
    step =
      @directions
      |> Map.get(dir)

    step_x = div(step, 10)
    step_y = rem(step, 10)

    {
      elem(pos, 0) + step_x,
      elem(pos, 1) + step_y
    }
  end

  def get_close_tiles(pos, map) do
    @directions
    |> Map.keys()
    |> Enum.map(fn dir ->
      new_pos = move(pos, dir)

      %{
        # "dir" => dir,
        "pipe" =>
          map
          |> Enum.at(elem(new_pos, 1))
          |> Enum.at(elem(new_pos, 0)),
        "pos" => new_pos
      }
    end)
    |> Enum.filter(&(Map.get(&1, "pipe") != nil))
  end
end
