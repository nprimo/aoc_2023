defmodule Day5.Part2 do
  def solver(input) do
    [seeds | rest] =
      input
      |> String.split("\n\n", trim: true)

    maps =
      rest
      |> Enum.map(&Day5.Part1.parse_map(&1))

    seeds
    |> parse_seeds()
    |> IO.inspect(charlists: :as_lists)
    |> List.flatten()
    |> Enum.min()
  end

  defp parse_seeds("seeds: " <> info) do
    info
    |> String.split()
    |> Enum.map(fn str ->
      case Integer.parse(str) do
        :error -> nil
        {num, _} -> num
      end
    end)
    |> Enum.chunk_every(2)
    |> Enum.map(fn [source_start, len] ->
      [source_start, source_start + len - 1]
    end)
  end

  # TODO: for each source range get the border inside range + lower range + 
  #  higher range
  #  For example:
  #    5..11 inside 7..9 -> %{inside: [7, 9], lower: [5, 6], upper: [10, 11]}
  #    7..9 inside 7..9 -> %{inside: [7, 9], lower: [], upper: []}
  #   It might be handy to have list of lists instead of single list

  # Make transformation for boundry numbers "inside" -> keep the inside/upper  
  # make sure to consider all the range inside and outside (upper union lower)
  # Get lowest number after all
end
