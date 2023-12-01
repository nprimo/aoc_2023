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
    #|> IO.inspect(label: "original", width: 10)
    |> Enum.map(fn line -> replace_num_string(line) end)
    |> Enum.map(fn line -> replace_num_string(line) end)
    #|> IO.inspect(label: "all num", width: 10)
    |> Enum.map(fn line -> line_to_numbers(line) end)
    #|> IO.inspect(limit: :infinity, width: 3)
    |> Enum.reduce(0, fn num, acc -> acc + num end)
  end

  @str_to_num %{
    "one" => "1ne",
    "two" => "2wo",
    "three" => "3hree",
    "four" => "4our",
    "five" => "5ive",
    "six" => "6ix",
    "seven" => "7even",
    "eight" => "8ight",
    "nine" => "9ine"
  }

  def replace_num_string(line) do
    line
    |> String.replace(Map.keys(@str_to_num), fn match ->
      Map.get(@str_to_num, match) |> to_string()
    end)
  end

  def line_to_numbers(""), do: 0

  def line_to_numbers(line) do
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
