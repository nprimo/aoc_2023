defmodule Day3 do
  def solver1(input) do
    rows =
      input
      |> String.trim_trailing()
      |> String.split("\n")

    symbol_positions =
      rows
      |> Enum.with_index()
      |> get_symbol_positions()

    rows
    |> Enum.with_index()
    |> get_number_with_position()
    |> Enum.filter(fn num -> is_part_number?(num, symbol_positions) end)
    |> Enum.map(fn %{"num" => num, "len" => _, "start" => _} -> num end)
    |> Enum.reduce(0, fn x, acc -> x + acc end)
  end

  def is_part_number?(
        %{"len" => len, "num" => _, "start" => [row_start, col_start]},
        symbol_positions
      ) do

    symbol_positions
    |> Enum.map(fn {row_symb, col_symb} ->
      if row_symb == row_start do
        if col_start - 1 == col_symb or col_start + len == col_symb do
          true
        end
      else
        if row_symb == row_start + 1 or row_symb == row_start - 1 do
          if(Enum.member?(Range.new(col_start - 1, col_start + len), col_symb)) do
            true
          end
        end
      end
    end)
    |> Enum.any?(&(&1 == true))
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
    # everything but digits or .
    matches =
      Regex.scan(~r/[^\d\.]/, row, return: :index)

    new_pos =
      matches
      |> Enum.map(fn [{col, _}] -> {row_number, col} end)

    symbol_positions = symbol_positions ++ new_pos

    get_symbol_positions(rest, symbol_positions)
  end
end
