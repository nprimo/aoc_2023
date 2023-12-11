defmodule Day11.Part2 do
  def solver(input, exp_factor \\ 1_000_000) do
    galaxy_map =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_charlist(&1))
      |> Nx.tensor(names: [:rows, :cols])

    galaxy_pos_og =
      input
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

    [empty_rows, empty_cols] = get_empy_rows_cols(galaxy_map)

    galaxy_pos =
      galaxy_pos_og
      |> Enum.map(&transform_pos(&1, empty_rows, empty_cols, exp_factor))

    get_min_distances(galaxy_pos)
    |> Enum.reduce(0, fn x, acc -> x + acc end)
  end

  def transform_pos({row, col}, empty_rows, empty_cols, exp_factor) do
    n_empty_rows =
      empty_rows
      |> Enum.filter(&(&1 < row))
      |> length()

    n_empty_cols =
      empty_cols
      |> Enum.filter(&(&1 < col))
      |> length()

    {
      row + n_empty_rows * (exp_factor - 1),
      col + n_empty_cols * (exp_factor - 1)
    }
  end

  def get_empy_rows_cols(galaxy_map) do
    {row_n, col_n} =
      galaxy_map.shape

    empty_rows =
      0..(row_n - 1)
      |> Enum.filter(fn row_n ->
        galaxy_map[rows: row_n]
        |> Nx.to_list()
        |> Enum.all?(&(&1 == ?.))
      end)

    empty_cols =
      0..(col_n - 1)
      |> Enum.filter(fn col_n ->
        galaxy_map[cols: col_n]
        |> Nx.to_list()
        |> Enum.all?(&(&1 == ?.))
      end)

    [
      empty_rows,
      empty_cols
    ]
  end

  def get_min_distances(galaxy_pos) do
    Day11.RC.comb(
      2,
      0..(length(galaxy_pos) - 1)
      |> Range.to_list()
    )
    |> MapSet.new()
    |> MapSet.to_list()
    |> Enum.map(fn [pos_1, pos_2] ->
      Day11.Part1.get_distance(
        Enum.at(galaxy_pos, pos_1),
        Enum.at(galaxy_pos, pos_2)
      )
    end)
  end
end
