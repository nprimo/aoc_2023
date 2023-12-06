defmodule Day6.Part1 do
  def solver(input) do
    ["Time: " <> time_info, "Distance: " <> distance_info] =
      input
      |> String.split("\n", trim: true)

    [time_info, distance_info] =
      [time_info, distance_info]
      |> Enum.map(fn info ->
        info
        |> String.trim()
        |> String.split("\s", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)

    time_info
    |> Enum.with_index()
    |> Enum.map(fn {total_time, row} ->
      1..total_time
      |> Enum.map(&travel_space(&1, total_time))
      |> Enum.filter(fn distance -> distance > Enum.at(distance_info, row) end)
      |> Enum.count()
    end)
    |> Enum.reduce(1, fn x, acc -> x * acc end)
  end

  def travel_space(t_pressed, total_time) do
    - (t_pressed ** 2) + total_time * t_pressed
  end
end
