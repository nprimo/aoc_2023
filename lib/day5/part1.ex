defmodule Day5.Part1 do
  def solver(input) do
    [seeds | rest] =
      input
      |> String.split("\n\n", trim: true)

    maps =
      rest
      |> Enum.map(&parse_map(&1))

    seeds
    |> parse_seeds()
    |> Enum.map(&seed_to_location(&1, maps))
    |> Enum.min()
  end

  defp parse_seeds("seeds: " <> seed_info) do
    seed_info
    |> String.split()
    |> Enum.map(fn str ->
      case Integer.parse(str) do
        :error -> nil
        {num, _} -> num
      end
    end)
  end

  def parse_map(map) do
    [_header | info_block] =
      map
      |> String.split("\n", trim: true)

    info_block
    |> Enum.map(fn substr ->
      substr
      |> String.split()
      |> Enum.map(&String.to_integer/1)
    end)
  end

  def in_range?(curr, [_, source_start, len])
      when curr >= source_start and curr <= source_start + len,
      do: true

  def in_range?(_, _), do: false

  def seed_to_location(source, []), do: source

  def seed_to_location(source, [curr_map | rest]) do
    new_source =
      case Enum.find(curr_map, &in_range?(source, &1)) do
        nil -> source
        [dest_start, source_start, _] -> source + (dest_start - source_start)
      end

    seed_to_location(new_source, rest)
  end
end
