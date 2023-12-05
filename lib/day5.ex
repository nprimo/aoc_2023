defmodule Day5 do
  def solver2(input) do
    [seeds | rest] =
      input
      |> String.split("\n\n", trim: true)

    maps =
      rest
      |> Enum.map(&parse_map(&1))

    seeds
    |> parse_seeds2()
    |> Enum.map(&get_seed_location(&1, maps))
    |> Enum.min()
  end

  defp parse_seeds2("seeds: " <> info) do
    info
    |> String.split()
    |> Enum.map(fn str ->
      case Integer.parse(str) do
        :error -> nil
        {num, _} -> num
      end
    end)
    |> Enum.chunk_every(2)
    |> Enum.map(fn [start, len] ->
      Range.new(start, start + len - 1)
      |> Range.to_list()
    end)
    |> List.flatten()
  end

  def solver1(input) do
    [seeds | rest] =
      input
      |> String.split("\n\n", trim: true)

    maps =
      rest
      |> Enum.map(&parse_map(&1))

    seeds
    |> parse_seeds()
    |> Enum.map(&get_seed_location(&1, maps))
    |> Enum.min()
  end

  defp get_seed_location(seed_num, maps)
  defp get_seed_location(curr, []), do: curr

  defp get_seed_location(curr_source, [curr_map | rest]) do
    %{
      "range_len" => range_len,
      "source_start" => source_start,
      "dest_start" => dest_start
    } = curr_map

    index_match =
      source_start
      |> Enum.with_index()
      |> Enum.map(fn {start, row} ->
        range_row =
          range_len
          |> Enum.at(row)

        {row, curr_source >= start and curr_source <= start + range_row}
      end)
      |> Enum.filter(fn {_row, bool} -> bool == true end)

    new_source =
      if index_match != [] do
        [{row, _} | _rest] = index_match

        dest_row =
          dest_start
          |> Enum.at(row)

        source_row =
          source_start
          |> Enum.at(row)

        curr_source + (dest_row - source_row)
      else
        curr_source
      end

    get_seed_location(new_source, rest)
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

  defp parse_map(map) do
    [_header | info_block] =
      map
      |> String.split("\n", trim: true)

    info_block
    |> Enum.map(&String.split(&1))
    |> parse_info()
  end

  defp parse_info(info, res \\ %{"source_start" => [], "dest_start" => [], "range_len" => []})
  defp parse_info([], res), do: res

  defp parse_info([h | rest], res) do
    [dest_start, source_start, range_len] =
      h
      |> Enum.map(fn str ->
        case Integer.parse(str) do
          :error -> nil
          {num, _} -> num
        end
      end)

    res =
      res
      |> Map.update(
        "source_start",
        [],
        fn curr -> curr ++ [source_start] end
      )
      |> Map.update(
        "dest_start",
        [],
        fn curr -> curr ++ [dest_start] end
      )
      |> Map.update(
        "range_len",
        [],
        fn curr -> curr ++ [range_len] end
      )

    parse_info(rest, res)
  end
end
