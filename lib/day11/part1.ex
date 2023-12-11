defmodule Day11.RC do
  def comb(0, _), do: [[]]
  def comb(_, []), do: []

  def comb(m, [h | t]) do
    for(l <- comb(m - 1, t), do: [h | l]) ++ comb(m, t)
  end
end

defmodule Day11.Part1 do
  def solver(input) do
    galaxy_map =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_charlist(&1))
      |> Nx.tensor(names: [:rows, :cols])

    expanded_map =
      get_expanded_galaxy(galaxy_map)

    galaxy_pos =
      expanded_map
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.map(fn {row, row_id} ->
        ~r/#/
        |> Regex.scan(row, return: :index)
        |> Enum.map(fn res ->
          case res do
            [{col, _}] -> {row_id, col}
            _ -> :cont
          end
        end)
      end)
      |> List.flatten()

    # possible combinations
    possible_comb =
      MapSet.new(Day11.RC.comb(2, 0..(length(galaxy_pos) - 1) |> Range.to_list()))
      |> MapSet.to_list()

    possible_comb
    |> Enum.map(fn [pos_1, pos_2] ->
      get_distance(
        Enum.at(galaxy_pos, pos_1),
        Enum.at(galaxy_pos, pos_2)
      )
    end)
    |> Enum.reduce(0, fn x, acc -> x + acc end)
  end

  def get_distance({row_1, col_1}, {row_2, col_2}) do
    abs(row_1 - row_2) + abs(col_1 - col_2)
  end

  def get_expanded_galaxy(galaxy_map, exp_factor \\ 2) do
    {row_n, col_n} =
      galaxy_map.shape

    empty_rows =
      0..(row_n - 1)
      |> Enum.filter(fn row_n ->
        galaxy_map[rows: row_n]
        |> Nx.to_list()
        |> Enum.all?(&(&1 == ?.))
      end)
      |> Enum.reverse()

    empty_cols =
      0..(col_n - 1)
      |> Enum.filter(fn col_n ->
        galaxy_map[cols: col_n]
        |> Nx.to_list()
        |> Enum.all?(&(&1 == ?.))
      end)
      |> Enum.reverse()

    galaxy_expanded_rows =
      Enum.reduce(empty_cols, galaxy_map, fn col_id, galaxy_map ->
        add_empty_col(galaxy_map, col_id, exp_factor - 1)
      end)

    expanded_galaxy =
      Enum.reduce(empty_rows, galaxy_expanded_rows, fn row_id, galaxy_expanded_rows ->
        add_empty_row(galaxy_expanded_rows, row_id, exp_factor - 1)
      end)

    expanded_galaxy
    |> Nx.to_list()
    |> Enum.join("\n")
  end

  defp add_empty_row(galaxy_map, row_id, n) do
    empty_row =
      Nx.broadcast(?., {n, elem(galaxy_map.shape, 1)}, names: [:rows, :cols])

    first_half =
      galaxy_map
      |> Nx.slice_along_axis(0, row_id, axis: :rows)

    second_half =
      galaxy_map
      |> Nx.slice_along_axis(row_id, elem(galaxy_map.shape, 0) - row_id, axis: :rows)

    Nx.concatenate([first_half, empty_row, second_half])
  end

  def add_empty_col(galaxy_map, col_id, n) do
    empty_col =
      Nx.broadcast(?., {elem(galaxy_map.shape, 0), n}, names: [:rows, :cols])

    first_half =
      galaxy_map
      |> Nx.slice_along_axis(0, col_id, axis: :cols)

    second_half =
      galaxy_map
      |> Nx.slice_along_axis(col_id, elem(galaxy_map.shape, 1) - col_id, axis: :cols)

    [empty_col, first_half, second_half]

    Nx.concatenate([first_half, empty_col, second_half], axis: :cols)
  end
end
