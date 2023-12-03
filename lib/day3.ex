defmodule Day3 do
  @symbols ~r/[\@\$\+\*\!\?\#]/
  def solver1(input) do
    rows =
      input
      |> String.trim_trailing()
      |> String.split("\n")

    symbol_positions =
      rows
      |> Enum.with_index()
      |> get_symbol_positions()

    numbers_with_position =
      rows
      |> Enum.with_index()
      |> get_number_with_position()
      |> Enum.map(fn num -> is_part_number?(num, symbol_positions) end)

    # filter number (with positions) based on symbol positions
  end

  def is_part_number?(num_with_position, symbol_positions) do
    %{"num" => num, "len" => len, "start" => [row, col]} = num_with_position

    symbol_positions
    |> Enum.map(fn [s_row, s_col] ->
      # same line 
      if(
        (row == s_row and (s_col == col - 1 or col + len)) or
          ((row == s_row - 1 or row == s_row + 1) and s_col >= col - 1 and col <= col + len)
      ) do
        true
      else
        false
      end
    end)
    |> IO.inspect()
  end

  def get_number_with_position(row, numbers_with_position \\ [])
  def get_number_with_position([], numbers_with_position), do: numbers_with_position

  def get_number_with_position([{row, row_number} | rest], numbers_with_position) do
    matches =
      Regex.scan(~r/\d+/, row, return: :index)

    nums =
      matches
      |> Enum.filter(fn match -> length(match) > 0 end)
      |> Enum.map(fn [{col_start, len}] ->
        start = [row_number, col_start]

        {num, _} =
          String.slice(row, col_start, len)
          |> Integer.parse()

        %{"num" => num, "len" => len, "start" => start}
      end)

    get_number_with_position(rest, numbers_with_position ++ nums)
  end

  def get_symbol_positions(row, symbol_positions \\ [])
  def get_symbol_positions([], symbol_positions), do: symbol_positions

  def get_symbol_positions([{row, row_number} | rest], symbol_positions) do
    matches =
      Regex.scan(@symbols, row, return: :index)

    new_pos =
      matches
      |> Enum.map(fn [{col, _}] -> {row_number, col} end)

    symbol_positions = symbol_positions ++ new_pos

    get_symbol_positions(rest, symbol_positions)
  end
end
