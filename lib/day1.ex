defmodule Day1 do
  def decrypt_calibration_1(encrypy_text) do
    lines =
      encrypy_text
      |> String.split("\n")

    lines
    |> Enum.map(fn line -> line_to_numbers(line) end)
    |> Enum.reduce(0, fn num, acc -> acc + num end)
  end

  def decrypt_calibration_2(encrypy_text) do
    lines =
      encrypy_text
      |> String.split("\n")

    lines
    |> Enum.map(fn line -> replace_num_string(line) end)
    |> Enum.map(fn line -> line_to_numbers(line) end)
    |> IO.inspect(limit: :infinity)
    |> Enum.reduce(0, fn num, acc -> acc + num end)
  end

  @str_to_num %{
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5,
    "six" => 6,
    "seven" => 7,
    "eight" => 8,
    "nine" => 9
  }

  defp replace_num_string(line) do
    line
    |> String.replace(Map.keys(@str_to_num), fn match ->
      Map.get(@str_to_num, match) |> to_string()
    end)
  end

  defp line_to_numbers(""), do: 0

  defp line_to_numbers(line) do
    line
    |> String.graphemes()
    |> Enum.filter(fn ch ->
      case Integer.parse(ch) do
        :error -> false
        _ -> true
      end
    end)
    |> combine_first_last()
  end

  defp combine_first_last(numbers) do
    {num, _} =
      Enum.join([hd(numbers), List.last(numbers)])
      |> Integer.parse()

    num
  end
end
