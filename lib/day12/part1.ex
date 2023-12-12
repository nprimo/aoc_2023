defmodule Day12.Part1 do
  def solver(input) do
    parsed =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, " "))
      |> Enum.map(fn [row_raw, info_raw] ->
        %{
          info:
            info_raw
            |> String.split(",")
            |> Enum.map(&String.to_integer/1),
          row_raw: row_raw
        }
      end)

    parsed
    |> Enum.map(&possible_rows(&1.row_raw, &1.info))
    |> Enum.map(&length(&1))
    |> Enum.reduce(0, fn x, acc -> x + acc end)
  end

  def possible_rows(row_raw, info) do
    unknow_pos =
      ~r/\?/
      |> Regex.scan(row_raw, return: :index)
      |> Enum.map(fn [{pos, _}] -> pos end)

    len_unkown = length(unknow_pos)

    possible_replace =
      len_unkown
      |> generate_patterns()
      |> List.flatten()
      |> Enum.chunk_every(len_unkown)

    possible_replace
    |> Enum.map(
      &(Enum.zip([&1, unknow_pos])
        |> Enum.reduce(row_raw, fn {char, pos}, acc ->
          acc
          |> String.graphemes()
          |> List.replace_at(pos, char)
          |> List.to_string()
        end))
    )
    |> Enum.filter(&is_valid_row(&1, info))
  end

  def get_curr_status(row) do
    ~r/#+/
    |> Regex.scan(row, return: :index)
    |> Enum.map(fn [{_pos, len}] -> len end)
  end

  def is_valid_row(row, info) do
    curr_status =
      row
      |> get_curr_status()

    curr_status == info
  end

  def generate_patterns(n) do
    generate_patterns(n, [])
  end

  defp generate_patterns(0, pattern), do: pattern

  defp generate_patterns(n, pattern) do
    for char <- [".", "#"] do
      generate_patterns(n - 1, pattern ++ [char])
    end
  end
end
