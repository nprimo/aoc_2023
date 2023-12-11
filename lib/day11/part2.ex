defmodule Day11.Part2 do
  def solver(input, exp_factor \\ 1_000_000) do
    galaxy_map =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_charlist(&1))
      |> Nx.tensor(names: [:rows, :cols])

    expanded_map =
      Day11.Part1.get_expanded_galaxy(galaxy_map, exp_factor)

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
    |> Enum.reduce(0, fn x, acc -> x + acc end)
  end
end
