defmodule Day14.Part1 do
  def solver(input) do
    t_map =
      input
      |> String.split("\n", trim: true)
      |> transpose_map()

    col_len =
      t_map
      |> Enum.at(0)
      |> String.length()

    t_map
    |> Enum.map(&tilt_col/1)
    |> Enum.map(&get_symbol_pos(&1, "O"))
    |> Enum.map(fn row ->
      row
      |> Enum.reduce(0, fn pos, acc -> col_len - pos + acc end)
    end)
    |> Enum.reduce(0, fn x, acc -> x + acc end)
  end

  def get_symbol_pos(row, symbol) do
    Regex.compile!(symbol)
    |> Regex.scan(row, return: :index)
    |> Enum.map(fn [{pos, _}] -> pos end)
  end

  def transpose_map(map) do
    map
    |> Enum.map(&String.graphemes/1)
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.join/1)
  end

  def tilt_col(col) do
    col
    |> String.split("#")
    |> Enum.map(&fill_empty_space/1)
    |> Enum.join("#")
  end

  def fill_empty_space(empty_space) do
    len = String.length(empty_space)

    case empty_space
         |> String.graphemes()
         |> Enum.count(&(&1 == "O")) do
      0 ->
        empty_space

      round_count ->
        0..(len - 1)
        |> Enum.map(fn pos ->
          if pos < round_count do
            "O"
          else
            "."
          end
        end)
        |> Enum.join("")
    end
  end
end
